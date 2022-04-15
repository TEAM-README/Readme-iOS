//
//  FeedDetailRepository.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/16.
//

import RxSwift

protocol FeedDetailRepository {
  
}

final class DefaultFeedDetailRepository {
  
  private let disposeBag = DisposeBag()

  init() {
    
  }
}

extension DefaultFeedDetailRepository: FeedDetailRepository {
  
}
