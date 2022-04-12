//
//  LoginRepository.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import RxSwift

protocol LoginRepository {
  
}

final class DefaultLoginRepository {
  
  private let disposeBag = DisposeBag()

  init() {
    
  }
}

extension DefaultLoginRepository: LoginRepository {
  
}
