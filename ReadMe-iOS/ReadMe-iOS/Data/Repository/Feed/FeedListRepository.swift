//
//  FeedListRepository.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/18.
//

import RxSwift

protocol FeedListRepository {
  func getFeedList(page: Int, category: String) -> Observable<FeedListEntity?>
  func getMyFeedList() -> Observable<MyFeedListEntity?>
}

final class DefaultFeedListRepository {
  
  private let networkService: FeedServiceType
  private let disposeBag = DisposeBag()

  init(service: FeedServiceType) {
    self.networkService = service
  }
}

extension DefaultFeedListRepository: FeedListRepository {
  func getFeedList(page: Int, category: String) -> Observable<FeedListEntity?> {
    print("REPOSITORY",category)
    return networkService.getBookListInformation(page: page, category: category).debug()
  }
  
  func getMyFeedList() -> Observable<MyFeedListEntity?> {
    return networkService.getMyFeedList()
  }
}
