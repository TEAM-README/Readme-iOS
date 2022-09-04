//
//  WriteCheckModel.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import Foundation

struct WriteCheckModel {
  let bookCategory: String
  let quote: String
  let impression: String
  let book: BookModel
}

struct BookModel: Codable {
  let isbn: String
  let subIsbn: String
  let title: String
  let author: String
  let image: String
}
