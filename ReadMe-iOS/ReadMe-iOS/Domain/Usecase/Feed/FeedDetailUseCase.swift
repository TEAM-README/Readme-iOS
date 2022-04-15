//
//  FeedDetailUseCase.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/16.
//

import RxSwift

protocol FeedDetailUseCase {

}

final class DefaultFeedDetailUseCase {
  
  private let repository: FeedRepository
  private let disposeBag = DisposeBag()
  
  init(repository: FeedRepository) {
    self.repository = repository
  }
}

extension DefaultFeedDetailUseCase: FeedDetailUseCase {
  
}
