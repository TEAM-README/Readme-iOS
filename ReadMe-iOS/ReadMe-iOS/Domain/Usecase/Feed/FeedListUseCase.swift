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
  func getMyFeedList()
  func getUserData()
  var feedList: PublishRelay<FeedListModel> { get set }
  var homeScrollToTop: PublishRelay<Void> { get set }
  var mypageScrollToTop: PublishRelay<Void> { get set }
  var userMyPageData: PublishRelay<MyPageModel> { get set }
}

final class DefaultFeedListUseCase: UseCaseType{
  
  private let feedRepository: FeedListRepository
  private let disposeBag = DisposeBag()
  
  var feedList = PublishRelay<FeedListModel>()
  var homeScrollToTop = PublishRelay<Void>()
  var mypageScrollToTop = PublishRelay<Void>()
  var userMyPageData = PublishRelay<MyPageModel>()
  
  init( feedrepository: FeedListRepository) {
    self.feedRepository = feedrepository
    self.addObserver()
  }
}

extension DefaultFeedListUseCase: FeedListUseCase {
  
  func getFeedList(pageNum: Int, category: [FeedCategory]) {
    // FIXME: - 서버 나오면 카테고리 부분 수정해야함
    let categoryString = category.isEmpty ? "" : makeCategoryString(category)
    feedRepository.getFeedList(page: 0, category: categoryString)
      .filter{ $0 != nil }
      .subscribe(onNext: { [weak self] entity in
        guard let self = self else { return }
        let model = entity!.toDomain()
        self.feedList.accept(model)
      }).disposed(by: self.disposeBag)
  }
  
  private func makeCategoryString(_ category: [FeedCategory]) -> String {
    var result = ""
    
    for (index,item) in category.enumerated() {
      result += item.rawValue
      if index != category.count - 1 {
        result += ","
      }
    }
    return result
  }
  
  func getMyFeedList() {
    feedRepository.getMyFeedList()
      .filter{ $0 != nil }
      .subscribe(onNext: { [weak self] entity in
        guard let self = self else { return }
        let model = entity!.toDomain()
        self.feedList.accept(model)
      }).disposed(by: self.disposeBag)
  }
  
  func getUserData() {
    feedRepository.getMyFeedList()
      .filter{ $0 != nil }
      .subscribe(onNext: { [weak self] entity in
        let myPageModel = MyPageModel.init(nickname: entity!.nickname,
                                           bookCount: entity!.count)
        self?.userMyPageData.accept(myPageModel)
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
    
    addObserverAction(.filterButtonClicked) { noti in
      if let category = noti.object as? [Category] {
        let filterCategoryList = category.map { category -> FeedCategory in
          return category.toFeedCategory()
        }
        self.getFeedList(pageNum: 0, category: filterCategoryList)
      }
    }
  }
}
