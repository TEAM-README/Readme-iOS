//
//  SignupUseCase.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import RxSwift

protocol SignupUseCase {

}

final class DefaultSignupUseCase {
  
  private let repository: SignupRepository
  private let disposeBag = DisposeBag()
  
  init(repository: SignupRepository) {
    self.repository = repository
  }
}

extension DefaultSignupUseCase: SignupUseCase {
  
}
