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

  var nicknameDuplicated: PublishSubject<Bool>{ get set }
  var nicknameHasCharacter: PublishSubject<Bool> { get set }
  var nicknameExceeded: PublishSubject<Bool>{ get set }
}

final class DefaultSignupUseCase {
  
  private let repository: SignupRepository
  private let disposeBag = DisposeBag()
  
  var nicknameDuplicated = PublishSubject<Bool>()
  var nicknameHasCharacter = PublishSubject<Bool>()
  var nicknameExceeded = PublishSubject<Bool>()
  
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
        print("USECASE 에서 중복 체크해줌")
      self.nicknameDuplicated.onNext(duplicated!)
    }).disposed(by: self.disposeBag)
  }
  
  private func hasCharacter(_ nickname: String) -> Bool {
//    let nickRegEx = "[가-힣A-Za-z0-9]{20}"
    let nickRegEx = "[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]{0,20}"

    let pred = NSPredicate(format:"SELF MATCHES %@", nickRegEx)
    return !pred.evaluate(with: nickname)
  }
  
  private func didExceedeMaxByte(_ nickname: String) -> Bool {
    return nickname.count > 20
  }
}
