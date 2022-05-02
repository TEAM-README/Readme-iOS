//
//  FilterRepository.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/02.
//

import RxSwift

protocol FilterRepository {
  
}

final class DefaultFilterRepository {
  
  private let networkService: FilterServiceType
  private let disposeBag = DisposeBag()

  init(service: FilterServiceType) {
    self.networkService = service
  }
}

extension DefaultFilterRepository: FilterRepository {
  
}
