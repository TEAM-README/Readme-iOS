//
//  WriteService.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import RxSwift

protocol WriteServiceType {
  func postWrite(bookCategory: String, quote: String, impression: String, book: BookModel) -> Observable<WriteCompleteEntity?>
}

extension BaseService: WriteServiceType {
  func postWrite(bookCategory: String, quote: String, impression: String, book: BookModel) -> Observable<WriteCompleteEntity?> {
    requestObjectInRx(.write(bookCategory: bookCategory, quote: quote, impression: impression, book: book))
  }
}
