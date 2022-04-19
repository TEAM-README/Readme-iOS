//
//  WriteRepository.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/19.
//

import RxSwift

protocol WriteRepository {
  
}


final class DefaultWriteRepository {
  
  private let disposeBag = DisposeBag()
  
  init() {
    
  }
}

extension DefaultWriteRepository: WriteRepository {
  
}
