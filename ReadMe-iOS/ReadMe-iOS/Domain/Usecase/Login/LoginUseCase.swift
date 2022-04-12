//
//  LoginUseCase.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import RxSwift

protocol LoginUseCase {

}

final class DefaultLoginUseCase {
  
  private let repository: LoginRepository
  private let disposeBag = DisposeBag()
  
  init(repository: LoginRepository) {
    self.repository = repository
  }
}

extension DefaultLoginUseCase: LoginUseCase {
  
}
