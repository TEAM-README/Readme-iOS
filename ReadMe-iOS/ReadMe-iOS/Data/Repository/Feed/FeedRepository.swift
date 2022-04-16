//
//  FeedDetailRepository.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/16.
//

import RxSwift

protocol FeedRepository {
  func getBookDetailInformation(idx: Int) -> Observable<FeedDetailEntity>
}

final class DefaultFeedRepository {
  
  private let disposeBag = DisposeBag()

  init() {
    
  }
}

extension DefaultFeedRepository: FeedRepository {
  
}
