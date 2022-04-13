//
//  SignupRepository.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import RxSwift

protocol SignupRepository {
  
}

final class DefaultSignupRepository {
  
  private let disposeBag = DisposeBag()

  init() {
    
  }
}

extension DefaultSignupRepository: SignupRepository {
  
}
