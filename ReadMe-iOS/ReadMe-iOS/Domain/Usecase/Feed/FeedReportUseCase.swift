//
//  FeedReportUseCase.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/09.
//

import RxSwift

protocol FeedReportUseCase {

}

final class DefaultFeedReportUseCase {
  
  private let repository: FeedReportRepository
  private let disposeBag = DisposeBag()
  
  init(repository: FeedReportRepository) {
    self.repository = repository
  }
}

extension DefaultFeedReportUseCase: FeedReportUseCase {
  
}
