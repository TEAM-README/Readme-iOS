//
//  WriteService.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import RxSwift

protocol WriteServiceType {
  func postWrite(bookTitle: String, bookAuthor: String, quote: String, impression: String) -> Observable<Bool?>
}

extension BaseService: WriteServiceType {
  func postWrite(bookTitle: String, bookAuthor: String, quote: String, impression: String) -> Observable<Bool?> {
    
    // FIXME: - 수정해야 함 
    requestObjectInRx(.postFeed(categoryName: "소설",
                                sentence: quote,
                                feeling: impression,
                                isbn: 0,
                                subIsbn: 0,
                                title: bookTitle,
                                author: bookAuthor,
                                image: ""))
  }
}
