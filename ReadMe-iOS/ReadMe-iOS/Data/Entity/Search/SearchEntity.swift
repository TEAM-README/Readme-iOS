//
//  SearchEntity.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/14.
//

import Foundation

struct SearchEntity: Codable {
  let lastBuildDate: String
  let total: Int
  let start: Int
  let display: Int
  let items: [SearchBookEntity]
  
  func toDomain() -> SearchModel {
    let bookModelList = self.items.map { entity in
      SearchBookModel.init(imgURL: entity.image,
                           title: entity.title,
                           author: entity.author)
    }
    
    return SearchModel(content: bookModelList)
  }
}

struct SearchBookEntity: Codable {
  let title: String
  let link: String
  let image: String
  let author, price, discount, publisher: String
  let pubdate, isbn, itemDescription: String

  enum CodingKeys: String, CodingKey {
      case title, link, image, author, price, discount, publisher, pubdate, isbn
      case itemDescription = "description"
  }
}
