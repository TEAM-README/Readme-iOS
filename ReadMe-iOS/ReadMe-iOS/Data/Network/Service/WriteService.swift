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
    requestObjectInRx(.write(bookTitle: bookTitle, bookAuthor: bookAuthor, quote: quote, impression: impression))
  }
}
