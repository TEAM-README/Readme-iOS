//
//  MyPageRepository.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import RxSwift

protocol MyPageRepository {
  
}

final class DefaultMyPageRepository {
  
  private let disposeBag = DisposeBag()

  init() {
    
  }
}

extension DefaultMyPageRepository: MyPageRepository {
  
}
