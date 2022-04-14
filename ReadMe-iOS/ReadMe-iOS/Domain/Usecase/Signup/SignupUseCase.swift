//
//  SignupUseCase.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import RxSwift

protocol SignupUseCase {
  func checkNicknameHasCharacter(nickname: String)
  func checkNicknameDuplicated(nickname: String)

  var nicknameDuplicated: PublishSubject<Bool>{ get set }
  var nicknameHasCharacter: PublishSubject<Bool> { get set }
}

final class DefaultSignupUseCase {
  
  private let repository: SignupRepository
  private let disposeBag = DisposeBag()
  
  var nicknameDuplicated = PublishSubject<Bool>()
  var nicknameHasCharacter = PublishSubject<Bool>()
  
  init(repository: SignupRepository) {
    self.repository = repository
  }
}

extension DefaultSignupUseCase: SignupUseCase {
  func checkNicknameHasCharacter(nickname: String) {
    let validState = isValid(nickname)
    self.nicknameHasCharacter.onNext(!validState)
  }
  
  func checkNicknameDuplicated(nickname: String) {
    repository.postNicknameValidCheck(nickname: nickname)
      .filter{ $0 != nil }
      .subscribe(onNext: { [weak self] state in
      guard let self = self else { return }
      self.nicknameDuplicated.onNext(state!)
    }).disposed(by: self.disposeBag)
  }
  
  private func isValid(_ nickname: String) -> Bool {
    let nickRegEx = "[가-힣A-Za-z0-9]{20}"
    let pred = NSPredicate(format:"SELF MATCHES %@", nickRegEx)
    return pred.evaluate(with: nickname)
    
  }
}
