//
//  HomeUseCase.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import RxSwift

protocol HomeUseCase {

}

final class DefaultHomeUseCase {
  
  private let repository: HomeRepository
  private let disposeBag = DisposeBag()
  
  init(repository: HomeRepository) {
    self.repository = repository
  }
}

extension DefaultHomeUseCase: HomeUseCase {
  
}
