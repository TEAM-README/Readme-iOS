//
//  FilterUseCase.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/02.
//

import RxSwift

protocol FilterUseCase {

}

final class DefaultFilterUseCase {
  
  private let repository: FilterRepository
  private let disposeBag = DisposeBag()
  
  init(repository: FilterRepository) {
    self.repository = repository
  }
}

extension DefaultFilterUseCase: FilterUseCase {
  
}
