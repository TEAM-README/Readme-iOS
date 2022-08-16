//
//  SearchRecentEntity.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/07/27.
//

import Foundation

struct SearchRecentEntity: Codable {
  let books: [BookModel?]
  
  func toDomain() -> SearchModel {
    let bookModelList = self.books.map { entity in
      SearchBookModel.init(imgURL: entity?.image ?? " ", title: entity?.title ?? " ", author: entity?.author ?? " ", isbn: (entity?.isbn ?? " ") + (entity?.subIsbn ?? " "))
    }
    return SearchModel(content: bookModelList)
  }
}
