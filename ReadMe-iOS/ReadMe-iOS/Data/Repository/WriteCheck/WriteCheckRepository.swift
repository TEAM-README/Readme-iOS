//
//  WriteCheckRepository.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import RxSwift

protocol WriteCheckRepository {
  
}

final class DefaultWriteCheckRepository {
  
  private let networkService: WriteServiceType
  private let disposeBag = DisposeBag()

  init(service: WriteServiceType) {
    self.networkService = service
  }
}

extension DefaultWriteCheckRepository: WriteCheckRepository {
  
}
