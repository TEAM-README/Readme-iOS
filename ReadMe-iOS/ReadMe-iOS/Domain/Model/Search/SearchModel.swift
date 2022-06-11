//
//  SearchModel.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/14.
//

import Foundation

struct SearchModel {
  let content: [SearchBookModel]
}

struct SearchBookModel {
  let imgURL: String
  var title: String
  var author: String
}

extension SearchBookModel {
  mutating func removeBoldText() {
    self.title = self.title.replacingOccurrences(of: "<b>", with: "")
    self.title = self.title.replacingOccurrences(of: "</b>", with: "")
    self.author = self.author.replacingOccurrences(of: "<b>", with: "")
    self.author = self.author.replacingOccurrences(of: "</b>", with: "")
  }
}
