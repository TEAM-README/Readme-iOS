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
  func getUserData()
  var feedList: PublishRelay<FeedListModel> { get set }
  var homeScrollToTop: PublishRelay<Void> { get set }
  var mypageScrollToTop: PublishRelay<Void> { get set }
  var userMyPageData: PublishRelay<MyPageModel> { get set }
}

final class DefaultFeedListUseCase: UseCaseType{
  
  private let myPageRepository: MyPageRepository
  private let feedRepository: FeedListRepository
  private let disposeBag = DisposeBag()
  
  var feedList = PublishRelay<FeedListModel>()
  var homeScrollToTop = PublishRelay<Void>()
  var mypageScrollToTop = PublishRelay<Void>()
  var userMyPageData = PublishRelay<MyPageModel>()
  
  init(myPageRepository: MyPageRepository,
       feedrepository: FeedListRepository) {
    self.myPageRepository = myPageRepository
    self.feedRepository = feedrepository
    self.addObserver()
  }
}

extension DefaultFeedListUseCase: FeedListUseCase {
  
  func getFeedList(pageNum: Int, category: [FeedCategory]) {
    // FIXME: - 서버 나오면 카테고리 부분 수정해야함
    let categoryString = category.isEmpty ? "" : ""
    feedRepository.getFeedList(page: 0, category: categoryString)
      .filter{ $0 != nil }
      .subscribe(onNext: { [weak self] entity in
        guard let self = self else { return }
        let model = entity!.toDomain()
        self.feedList.accept(model)
      }).disposed(by: self.disposeBag)
  }
  
  func getUserData() {
    myPageRepository.getUserNickname()
      .filter{ $0 != nil }
      .subscribe(onNext: { [weak self] entity in
        guard let self = self else { return }
        self.userMyPageData.accept(entity!.toDomain())
      }).disposed(by: self.disposeBag)
  }
  
}

extension DefaultFeedListUseCase {
  private func addObserver() {
    addObserverAction(.homeButtonClicked) { _ in
      self.homeScrollToTop.accept(())
    }
    
    addObserverAction(.mypageButtonClicked) { _ in
      self.mypageScrollToTop.accept(())
    }
    
    addObserverAction(.writeComplete) { noti in
      if let object = noti.object as? WriteCheckModel {
        
      }
    }
  }
}
