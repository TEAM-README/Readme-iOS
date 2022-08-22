//
//  SearchEntity.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/14.
//

import Foundation

struct SearchEntity: Codable {
  let lastBuildDate: String
  let total, start, display: Int
  let items: [SearchBookEntity]
  
  func toDomain() -> SearchModel {
    let bookModelList = self.items.map { entity in
      SearchBookModel.init(imgURL: entity.image,
                           title: entity.title,
                           author: (entity.author == "" ? "작자미상" : entity.author) ?? "작자미상",
                           isbn: entity.isbn ?? " ")
    }
    
    return SearchModel(content: bookModelList)
  }
}

struct SearchBookEntity: Codable {
  let title: String
  let link: String
  let image: String
  let discount, publisher, pubdate: String
  let itemDescription: String
  let author, isbn: String?

  enum CodingKeys: String, CodingKey {
    case title, link, image, author, discount, publisher, pubdate, isbn
      case itemDescription = "description"
  }
}
