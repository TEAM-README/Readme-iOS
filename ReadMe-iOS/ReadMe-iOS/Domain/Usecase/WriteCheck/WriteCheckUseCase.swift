//
//  WriteCheckUseCase.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import RxSwift
import RxRelay

protocol WriteCheckUseCase {
  
}

final class DefaultWriteCheckUseCase {
  
  private let repository: WriteCheckRepository
  private let disposeBag = DisposeBag()
  
  init(repository: WriteCheckRepository) {
    self.repository = repository
  }
}

extension DefaultWriteCheckUseCase: WriteCheckUseCase {
  
}
