//
//  SearchService.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/18.
//

import Foundation
import RxSwift

protocol SearchServiceType {
  func getSearchRecent() -> Observable<SearchEntity?>
}

extension BaseService: SearchServiceType {
  func getSearchRecent() -> Observable<SearchEntity?> {
    requestObjectInRx(.getSearchRecent)
  }
}
