//
//  SearchRepository.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/14.
//

import RxSwift

protocol SearchRepository {
  func getSearchBookInformation() -> Observable<SearchEntity?>
}

final class DefaultSearchRepository {
  
  private let networkService: SearchServiceType
  private let disposeBad = DisposeBag()
  
  init(service: SearchServiceType) {
    self.networkService = service
  }
}

extension DefaultSearchRepository: SearchRepository {
  func getSearchBookInformation() -> Observable<SearchEntity?> {
//    return networkService.getSearchRecent()
    return makeMockSearchEntity()
  }
}

extension DefaultSearchRepository {
  private func makeMockSearchEntity() -> Observable<SearchEntity?> {
    return .create { observer in
      let fakeSearchInfo1 = SearchBookEntity.init(imgURL: "https://bookthumb-phinf.pstatic.net/cover/071/526/07152669.jpg?udate=20220203",
                                                 title: "운명을 바꾸는 부동산 투자 수업 운명을 바꾸는 부동산 투자 수업이지롱가리아아아아하나두울셋",
                                                 author: "부동산읽어주는남자(정태익) 저")
      let fakeSearchInfo2 = SearchBookEntity.init(imgURL: "https://bookthumb-phinf.pstatic.net/cover/071/526/07152669.jpg?udate=20220203",
                                                 title: "부동산투우자 수업이지롱가리아아아아하나두울셋",
                                                 author: "혜화동 쌍가마 저")
      let fakeSearchInfo3 = SearchBookEntity.init(imgURL: "https://bookthumb-phinf.pstatic.net/cover/071/526/07152669.jpg?udate=20220203",
                                                 title: "읭",
                                                 author: "빈수양")
      
      let fakeSearchInformation = SearchEntity.init(content: [fakeSearchInfo1, fakeSearchInfo2, fakeSearchInfo3])
      observer.onNext(fakeSearchInformation)
      return Disposables.create()
    }
  }
}
