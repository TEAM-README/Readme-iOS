//
//  WriteUseCase.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/19.
//

import RxSwift
import RxRelay

protocol WriteUseCase {
  
}

final class DefaultWriteUseCase {
  
  private let repository: WriteRepository
  private let disposeBag = DisposeBag()
  
  init(repository: WriteRepository) {
    self.repository = repository
  }
}

extension DefaultWriteUseCase: WriteUseCase {
  
}
