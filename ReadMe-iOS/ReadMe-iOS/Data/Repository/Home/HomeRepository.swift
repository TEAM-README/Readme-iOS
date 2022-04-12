//
//  HomeRepository.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import RxSwift

protocol HomeRepository {
  
}

final class DefaultHomeRepository {
  
  private let disposeBag = DisposeBag()

  init() {
    
  }
}

extension DefaultHomeRepository: HomeRepository {
  
}
