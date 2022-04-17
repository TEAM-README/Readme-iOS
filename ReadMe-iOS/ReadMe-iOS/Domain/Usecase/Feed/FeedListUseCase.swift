//
//  FeedListUseCase.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/18.
//

import RxSwift

protocol FeedListUseCase {

}

final class DefaultFeedListUseCase {
  
  private let repository: FeedListRepository
  private let disposeBag = DisposeBag()
  
  init(repository: FeedListRepository) {
    self.repository = repository
  }
}

extension DefaultFeedListUseCase: FeedListUseCase {
  
}
