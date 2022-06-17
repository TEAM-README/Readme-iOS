//
//  WriteService.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import RxSwift

protocol WriteServiceType {
  func postWrite(bookCategory: String, bookTitle: String, bookAuthor: String, bookCover: String, quote: String, impression: String, isbn: String, subIsbn: String) -> Observable<WriteCompleteEntity?>
}

extension BaseService: WriteServiceType {
  func postWrite(bookCategory: String, bookTitle: String, bookAuthor: String, bookCover: String, quote: String, impression: String, isbn: String, subIsbn: String) -> Observable<WriteCompleteEntity?> {
    requestObjectInRx(.write(bookCategory: bookCategory, bookTitle: bookTitle, bookAuthor: bookAuthor, bookCover: bookCover, quote: quote, impression: impression, isbn: isbn, subIsbn: subIsbn))
  }
}
