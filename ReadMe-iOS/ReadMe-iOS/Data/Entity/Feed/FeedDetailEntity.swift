//
//  FeedDetailEntity.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/16.
//

import Foundation

struct FeedDetailEntity: Codable {
  let feed: FeedDetailDataModel
}

struct FeedDetailDataModel: Codable {
  let id: Int
  let categoryName, sentence, feeling: String
  let reportedCount: Int
  let createdAt: String
  let isDeleted: Bool
  let book: Book
  let user: User
  
  func toDomain() -> FeedDetailModel {
    FeedDetailModel.init(idx:self.id,
                         imgURL: self.book.image ?? "",
                         category: self.categoryName,
                         title: self.book.title ?? "",
                         author: self.book.author ?? "",
                         sentence: self.sentence,
                         comment: self.feeling,
                         nickname: self.user.nickname,
                         date: self.createdAt)
  }
}

struct Book: Codable {
    let isbn, subIsbn, title, author: String?
    let image: String?
}

struct User: Codable {
    let id: Int
    let nickname: String
}
