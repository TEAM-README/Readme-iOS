//
//  WriteCompleteRepository.swift
//  ReadMe-iOS
//
//  Created by μμλΉ on 2022/04/22.
//

import RxSwift

protocol WriteCompleteRepository {
  
}

final class DefaultWriteCompleteRepository {
  
  private let disposeBag = DisposeBag()

  init() {
    
  }
}

extension DefaultWriteCompleteRepository: WriteCompleteRepository {
  
}
