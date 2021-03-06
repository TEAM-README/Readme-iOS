//
//  SearchService.swift
//  ReadMe-iOS
//
//  Created by μμλΉ on 2022/04/18.
//

import Foundation
import RxSwift

protocol SearchServiceType {
  func getSearchResult(query: String, display: Int, start: Int, sort: String) -> Observable<SearchEntity?>
  func getSearchRecent() -> Observable<SearchEntity?>
}

extension BaseService: SearchServiceType {
  func getSearchResult(query: String, display: Int, start: Int, sort: String) -> Observable<SearchEntity?> {
    return naverRequestObjectInRx(.getSearch(query: query, display: display, start: start, sort: sort))
  }
  
  func getSearchRecent() -> Observable<SearchEntity?> {
    requestObjectInRx(.getSearchRecent)
  }
}
