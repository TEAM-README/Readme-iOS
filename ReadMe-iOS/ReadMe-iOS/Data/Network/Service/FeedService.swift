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
}

extension BaseService: FeedServiceType {
  func getBookDetailInformation(idx: Int) -> Observable<FeedDetailEntity?> {
    requestObjectInRx(.getFeedDetail(idx: idx))
  }
}
