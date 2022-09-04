//
//  FeedService.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/16.
//

import Foundation
import RxSwift

protocol FeedServiceType {
  func getBookDetailInformation(idx: Int) -> Observable<FeedDetailEntity?>
  func getBookListInformation(page: Int,category:String) -> Observable<FeedListEntity?>
  func getMyFeedList() -> Observable<MyFeedListEntity?>
  func getMyFeedListInAF(completion: @escaping (Result<MyFeedListEntity?,Error>) -> Void)
}

extension BaseService: FeedServiceType {
  func getBookDetailInformation(idx: Int) -> Observable<FeedDetailEntity?> {
    requestObjectInRx(.getFeedDetail(idx: idx))
  }
  
  func getBookListInformation(page: Int,category:String) -> Observable<FeedListEntity?> {
    requestObjectInRx(.getFeedList(filter: category))
  }
  
  func getMyFeedList() -> Observable<MyFeedListEntity?> {
    requestObjectInRx(.getMyFeedList)
  }
  
  func getMyFeedListInAF(completion: @escaping (Result<MyFeedListEntity?,Error>) -> Void) {
    requestObject(.getMyFeedList, completion: completion)
  }
}
