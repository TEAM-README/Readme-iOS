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
  let title: String
  let author: String
}
