//
//  SignupUseCase.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import RxSwift
import RxRelay

protocol SignupUseCase {
  func checkNicknameHasCharacter(nickname: String)
  func checkNicknameExceed(nickname: String)
  func checkNicknameDuplicated(nickname: String)
  func postUserSignup(data: SignupDTO)

  var nicknameDuplicated: PublishSubject<Bool>{ get set }
  var nicknameHasCharacter: PublishSubject<Bool> { get set }
  var nicknameExceeded: PublishSubject<Bool>{ get set }
  var signupState: PublishRelay<Bool> { get set }
}

final class DefaultSignupUseCase {
  
  private let repository: SignupRepository
  private let disposeBag = DisposeBag()
  
  var nicknameDuplicated = PublishSubject<Bool>()
  var nicknameHasCharacter = PublishSubject<Bool>()
  var nicknameExceeded = PublishSubject<Bool>()
  var signupState = PublishRelay<Bool>()

  init(repository: SignupRepository) {
    self.repository = repository
  }
}

extension DefaultSignupUseCase: SignupUseCase {
  func checkNicknameHasCharacter(nickname: String) {
    self.nicknameHasCharacter.onNext(hasCharacter(nickname))
  }
  
  func checkNicknameExceed(nickname: String) {
    self.nicknameExceeded.onNext(didExceedeMaxByte(nickname))
  }
  
  func checkNicknameDuplicated(nickname: String) {
    repository.postNicknameInValidCheck(nickname: nickname)
      .filter{ $0 != nil }

      .subscribe(onNext: { [weak self] duplicated in
      guard let self = self else { return }
        self.nicknameDuplicated.onNext(duplicated!.available)
    }).disposed(by: self.disposeBag)
  }
  
  func postUserSignup(data: SignupDTO) {
    repository.postUserSignup(data: data)
      .filter {$0 != nil}
      .subscribe(onNext: { [weak self] entity in
        guard let self = self else { return }
        UserDefaults.standard.setValue(data.platform, forKeyPath: UserDefaultKeyList.Auth.provider)
        UserDefaults.standard.setValue(data.accessToken, forKeyPath: UserDefaultKeyList.Auth.userToken)
        UserDefaults.standard.setValue(entity!.accessToken, forKeyPath: UserDefaultKeyList.Auth.accessToken)
        UserDefaults.standard.setValue(entity!.user.id, forKeyPath: UserDefaultKeyList.Auth.userID)
        UserDefaults.standard.setValue(entity!.user.nickname, forKeyPath: UserDefaultKeyList.Auth.userNickname)
        
        self.signupState.accept(true)
      }).disposed(by: self.disposeBag)
  }

  private func hasCharacter(_ nickname: String) -> Bool {
    let nickRegEx = "[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]{0,7}"

    let pred = NSPredicate(format:"SELF MATCHES %@", nickRegEx)
    return !pred.evaluate(with: nickname)
  }
  
  private func didExceedeMaxByte(_ nickname: String) -> Bool {
    return nickname.count > 7
  }
}
