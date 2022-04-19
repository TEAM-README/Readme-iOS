//
//  FeedListUseCase.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/18.
//

import RxSwift
import RxRelay

protocol FeedListUseCase {
  func getFeedList(pageNum: Int, category: [FeedCategory])
  var feedList: PublishRelay<FeedListModel> { get set }
  var scrollToTop: PublishRelay<Void> { get set }
}

final class DefaultFeedListUseCase: UseCaseType{
  
  private let repository: FeedListRepository
  private let disposeBag = DisposeBag()
  
  var feedList = PublishRelay<FeedListModel>()
  var scrollToTop = PublishRelay<Void>()
  
  init(repository: FeedListRepository) {
    self.repository = repository
    self.addObserver()
  }
}

extension DefaultFeedListUseCase: FeedListUseCase {
  func getFeedList(pageNum: Int, category: [FeedCategory]) {
    // FIXME: - 서버 나오면 카테고리 부분 수정해야함
    let categoryString = category.isEmpty ? "" : ""
    repository.getFeedList(page: 0, category: categoryString)
      .filter{ $0 != nil }
      .subscribe(onNext: { [weak self] entity in
        guard let self = self else { return }
        let model = entity!.toDomain()
        self.feedList.accept(model)
      }).disposed(by: self.disposeBag)
  }
  
}

extension DefaultFeedListUseCase {
  private func addObserver() {
    addObserverAction(.homeButtonClicked) { _ in
      self.scrollToTop.accept(())
    }
  }
}
