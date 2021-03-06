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
  private let isMyPage: Bool
  private var category: [FeedCategory] = []
  private let useCase: FeedListUseCase
  private let disposeBag = DisposeBag()
  
  // MARK: - Inputs
  struct Input {
    let viewWillAppearEvent: Observable<Void>
    let category: Observable<[FeedCategory]>
  }
  
  // MARK: - Outputs
  struct Output {
    var isMyPageMode = PublishRelay<Bool>()
    var scrollToTop = PublishRelay<Void>()
    var feedList = PublishRelay<[FeedListDataModel]>()
    var userData = PublishRelay<MyPageModel>()
  }
  
  init(useCase: FeedListUseCase,isMyPage: Bool) {
    self.useCase = useCase
    self.isMyPage = isMyPage
  }
}

extension FeedListViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    input.viewWillAppearEvent.subscribe(onNext: { [weak self] in
      guard let self = self else { return }
      output.isMyPageMode.accept(self.isMyPage)
      self.useCase.getUserData()
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
    let homeScrollToTopRelay = useCase.homeScrollToTop
    let mypageScrollToTopRelay = useCase.mypageScrollToTop
    let userDataRelay = useCase.userMyPageData
    
    Observable.combineLatest(userDataRelay,feedListRelay) { userData, feedListData -> FeedBundleData in
      FeedBundleData(myPageData: userData, feedListData: feedListData)
    }.subscribe(onNext: { [weak self] data in
      guard let self = self else { return }
      var feedDatasource: [FeedListDataModel] = []
      let feedList = self.makeFeedContentViewModel(data.feedListData,isMyPage: self.isMyPage).map { contentViewModel in
        FeedListDataModel(type: .content, dataSource: contentViewModel)
      }
      feedDatasource.append(contentsOf: feedList)
      
      if feedList.isEmpty {
        feedDatasource.append(FeedListDataModel(type: .empty,
                                                dataSource: FeedListEmtpyViewData(isMyPage: self.isMyPage)))
      }

      if !self.isMyPage { // 마이페이지가 아니면 카테고리 정보를 불러와야 함.
        let category = FeedListDataModel(type: .category,
                                         dataSource: FeedCategoryViewModel(category: data.feedListData.category))
        feedDatasource.insert(category, at: 0)
          output.feedList.accept(feedDatasource)
        
      } else {
        let userData = FeedListDataModel(type: .myPageHeader, dataSource: data.myPageData)
        feedDatasource.insert(userData, at: 0)
        output.feedList.accept(feedDatasource)
        
      }
    }).disposed(by: self.disposeBag)
    
    homeScrollToTopRelay.subscribe(onNext: {
      if !self.isMyPage { output.scrollToTop.accept(()) }
    }).disposed(by: self.disposeBag)
    
    mypageScrollToTopRelay.subscribe(onNext: {
      if self.isMyPage { output.scrollToTop.accept(()) }
    }).disposed(by: self.disposeBag)
    
    userDataRelay.subscribe(onNext: {  model in
      output.userData.accept(model)
    }).disposed(by: self.disposeBag)
  }
  

}

extension FeedListViewModel {
  private func makeFeedContentViewModel(_ model: FeedListModel,isMyPage: Bool) -> [FeedListContentViewModel] {
    let contents = model.feedList.map { detailModel in
      FeedListContentViewModel.init(idx: detailModel.idx,
                                    category: detailModel.category,
                                    title: detailModel.title,
                                    sentenceTextViewModel: makeTextViewModel(type: .sentence,
                                                                             text: detailModel.sentence),
                                    commentTextViewModel: makeTextViewModel(type: .comment,
                                                                             text: detailModel.comment),
                                    nickname: detailModel.nickname,
                                    date: detailModel.date,
      isMyPage: isMyPage)
    }
    return contents
  }
  
  private func makeTextViewModel(type : FeedListTextType, text: String) -> FeedTextViewModel{
    let font: UIFont
    let lineHeightMultiple: CGFloat
    let textViewWidth: CGFloat
    let maxLine: Int
    
    switch(type) {
      case .sentence:
        font = .readMeFont(size: 13, type: .regular)
        lineHeightMultiple = 1.33
        textViewWidth = screenWidth - 70
        maxLine = 4
      case .comment:
        font = .readMeFont(size: 14, type: .extraLight)
        lineHeightMultiple = 1.33
        textViewWidth = screenWidth - 70
        maxLine = 6
    }
    let textHeight = calculateTextViewHeight(maxLine: maxLine,
                                             width: textViewWidth,
                                             font: font,
                                             lineHeightMultiple: lineHeightMultiple,
                                             text: text)
    
    return FeedTextViewModel(textFont: font,
                             lineHeightMultiple: lineHeightMultiple,
                             textViewHeight: textHeight,
                             content: text)
  }
  
  private func calculateTextViewHeight(maxLine: Int, width: CGFloat,font: UIFont, lineHeightMultiple: CGFloat, text: String) -> CGFloat {
    let mockTextView = UITextView()
    let newSize = CGSize(width: width, height: CGFloat.infinity)
    mockTextView.textContainerInset = .zero
    mockTextView.textContainer.lineFragmentPadding = 0
    mockTextView.setTextWithLineHeight(text: text, lineHeightMultiple: lineHeightMultiple)
    mockTextView.isScrollEnabled = false
    mockTextView.textContainer.maximumNumberOfLines = maxLine
    mockTextView.translatesAutoresizingMaskIntoConstraints = false
    mockTextView.font = font
    let estimatedSize = mockTextView.sizeThatFits(newSize)
    return estimatedSize.height
  }
}

protocol FeedListDataSource { }

struct FeedListDataModel {
  let type: FeedListContentType
  let dataSource: FeedListDataSource
}

enum FeedListContentType {
  case myPageHeader
  case category
  case content
  case empty
}

enum FeedListTextType {
  case sentence
  case comment
}

struct FeedBundleData {
  let myPageData: MyPageModel
  let feedListData: FeedListModel
}

struct FeedListEmtpyViewData:FeedListDataSource {
  let isMyPage: Bool
}
