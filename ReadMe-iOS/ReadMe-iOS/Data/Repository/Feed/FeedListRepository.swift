//
//  FeedListRepository.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/18.
//

import RxSwift

protocol FeedListRepository {
  
}

final class DefaultFeedListRepository {
  
  private let disposeBag = DisposeBag()

  init() {
    
  }
}

extension DefaultFeedListRepository: FeedListRepository {
  
}
