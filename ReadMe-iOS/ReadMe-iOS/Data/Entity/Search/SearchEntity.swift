//
//  SearchEntity.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/14.
//

import Foundation

struct SearchEntity: Codable {
  let content: [SearchBookEntity]
  
  func toDomain() -> SearchModel {
    let bookModelList = self.content.map { entity in
      SearchBookModel.init(imgURL: entity.imgURL,
                           category: entity.category,
                           title: entity.title,
                           author: entity.author)
    }
    
    return SearchModel(content: bookModelList)
  }
}

struct SearchBookEntity: Codable {
  let imgURL: String
  let category: String
  let title: String
  let author: String
}
