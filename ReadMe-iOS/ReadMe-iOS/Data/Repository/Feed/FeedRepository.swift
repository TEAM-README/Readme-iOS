//
//  FeedDetailRepository.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/16.
//

import RxSwift

protocol FeedRepository {
  func getBookDetailInformation(idx: Int) -> Observable<FeedDetailEntity?>
}

final class DefaultFeedRepository {
  
  private let networkService: FeedServiceType
  private let disposeBag = DisposeBag()

  init(service: FeedServiceType) {
    self.networkService = service
  }
}

extension DefaultFeedRepository: FeedRepository {
  func getBookDetailInformation(idx: Int) -> Observable<FeedDetailEntity?> {
    return networkService.getBookDetailInformation(idx: idx)
  }
}
