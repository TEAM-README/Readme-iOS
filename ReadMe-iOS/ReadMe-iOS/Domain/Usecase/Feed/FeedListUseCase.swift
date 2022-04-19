//
//  FeedListUseCase.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/18.
//

import RxSwift
import RxRelay

protocol FeedListUseCase {
  func getFeedList(pageNum: Int, category: FeedCategory?)
  var feedList: PublishRelay<FeedListModel> { get set }
}

final class DefaultFeedListUseCase {
  
  private let repository: FeedListRepository
  private let disposeBag = DisposeBag()
  
  var feedList = PublishRelay<FeedListModel>()
  
  init(repository: FeedListRepository) {
    self.repository = repository
  }
}

extension DefaultFeedListUseCase: FeedListUseCase {
  func getFeedList(pageNum: Int, category: FeedCategory?) {
    let categoryString = (category != nil) ? category?.rawValue : ""
    repository.getFeedList(page: 0, category: categoryString)
      .filter{ $0 != nil }
      .subscribe(onNext: { [weak self] entity in
        guard let self = self else { return }
        let model = entity!.toDomain()
        self.feedList.accept(model)
      }).disposed(by: self.disposeBag)
  }
}
