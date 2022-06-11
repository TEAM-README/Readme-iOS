//
//  SearchRepository.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/14.
//

import RxSwift

protocol SearchRepository {
  func getSearchResult(query: String, display: Int, start: Int, sort: String) -> Observable<SearchEntity?>
  func getSearchRecentResult() -> Observable<SearchEntity?>
}

final class DefaultSearchRepository {
  
  private let networkService: SearchServiceType
  private let disposeBad = DisposeBag()
  
  init(service: SearchServiceType) {
    self.networkService = service
  }
}

extension DefaultSearchRepository: SearchRepository {
  func getSearchResult(query: String, display: Int, start: Int, sort: String) -> Observable<SearchEntity?> {
    return networkService.getSearchResult(query: query, display: display, start: start, sort: sort)
  }
  
  func getSearchRecentResult() -> Observable<SearchEntity?> {
//    return networkService.getSearchRecent()
    return makeMockSearchEntity()
  }
}

extension DefaultSearchRepository {
  private func makeMockSearchEntity() -> Observable<SearchEntity?> {
    return .create { observer in
      let mockSearchInfo = SearchBookEntity.init(title: "안녕하세욜", link: "-", image: "https://bookthumb-phinf.pstatic.net/cover/071/526/07152669.jpg?udate=20220203", author: "양슁", price: "2000", discount: "10%", publisher: "-", pubdate: "-", isbn: "-", itemDescription: "-")
      let mockSearchInformation = SearchEntity.init(lastBuildDate: "---", total: 1, start: 1, display: 10, items: [mockSearchInfo])
      
      observer.onNext(mockSearchInformation)
      return Disposables.create()
    }
  }
}
