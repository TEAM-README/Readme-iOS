//
//  FeedDetailEntity.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/16.
//

import Foundation

struct FeedDetailEntity: Codable {
  let id: Int
  let categoryName, title, sentence, feeling: String
  let reportedCount: Int
  let createdAt: String
  let updatedAt: String?
  let isDeleted: Bool
  let user: User
  let author: String?
  let image: String?
  
  func toDomain() -> FeedDetailModel {
    FeedDetailModel.init(idx:self.id,
                         imgURL: self.image ?? "",
                         category: self.categoryName,
                         title: self.title,
                         author: self.author ?? "",
                         sentence: self.sentence,
                         comment: self.feeling,
                         nickname: self.user.nickname,
                         date: self.createdAt)
  }
}

struct User: Codable {
    let id: Int
    let nickname: String
}
