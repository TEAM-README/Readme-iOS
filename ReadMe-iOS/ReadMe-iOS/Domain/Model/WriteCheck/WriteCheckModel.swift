//
//  WriteCheckModel.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import Foundation

struct WriteCheckModel {
  let bookCover: String?
  let bookTitle: String
  let bookAuthor: String
  let bookCategory: String
  let quote: String
  let impression: String
  let isbn: String
  let subisbn: String
}

struct WriteRequestModel {
  let bookCategory: String
  let bookTitle: String
  let bookAuthor: String
  let bookCover: String
  let quote: String
  let impression: String
  let isbn: String
  let subisbn: String
}
