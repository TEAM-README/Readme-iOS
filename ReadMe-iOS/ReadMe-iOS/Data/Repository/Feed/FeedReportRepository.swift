//
//  FeedReportRepository.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/09.
//

import RxSwift

protocol FeedReportRepository {
  
}

final class DefaultFeedReportRepository {
  
  private let disposeBag = DisposeBag()

  init() {
    
  }
}

extension DefaultFeedReportRepository: FeedReportRepository {
  
}
