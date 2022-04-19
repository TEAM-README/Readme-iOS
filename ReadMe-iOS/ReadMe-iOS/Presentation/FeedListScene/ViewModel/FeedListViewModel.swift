//
//  FeedListViewModel.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/18.
//

import RxSwift
import RxRelay

final class FeedListViewModel: ViewModelType {

  private var pageNum: Int = 0
  private var category: FeedCategory?
  private let useCase: FeedListUseCase
  private let disposeBag = DisposeBag()
  
  // MARK: - Inputs
  struct Input {
    let viewWillAppearEvent: Observable<Void>
    let category: Observable<FeedCategory>
  }
  
  // MARK: - Outputs
  struct Output {
    var scrollToTop = PublishRelay<Void>()
    var feedList = PublishRelay<FeedListModel>()
  }
  
  init(useCase: FeedListUseCase) {
    self.useCase = useCase
  }
}

extension FeedListViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    input.viewWillAppearEvent.subscribe(onNext: { [weak self] in
      guard let self = self else { return }
      self.useCase.getFeedList(pageNum: self.pageNum, category: self.category)
    }).disposed(by: self.disposeBag)
    
    input.category.subscribe(onNext: { [weak self] category in
      guard let self = self else { return }
      self.category = category
    }).disposed(by: self.disposeBag)
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    let feedListRelay = useCase.feedList
    feedListRelay.subscribe(onNext: { feedListModel in
      output.feedList.accept(feedListModel)
    }).disposed(by: self.disposeBag)
  }
}
