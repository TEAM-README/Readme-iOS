//
//  SearchRepository.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/14.
//

import RxSwift

protocol SearchRepository {
  
}

final class DefaultSearchRepository {
  
  private let disposeBad = DisposeBag()
  
  init() {
    
  }
}

extension DefaultSearchRepository: SearchRepository {
  
}
