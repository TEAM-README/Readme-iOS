//
//  WriteUseCase.swift
//  ReadMe-iOS
//
//  Created by μμλΉ on 2022/04/19.
//

import RxSwift
import RxRelay

protocol WriteUseCase {
  
}

final class DefaultWriteUseCase {
  
  private let disposeBag = DisposeBag()
  
  init() {
    
  }
}

extension DefaultWriteUseCase: WriteUseCase {
  
}
