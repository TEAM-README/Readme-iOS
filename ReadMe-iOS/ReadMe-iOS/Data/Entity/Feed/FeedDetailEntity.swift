//
//  FeedDetailEntity.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/16.
//

import Foundation

struct FeedDetailEntity: Codable {
  let idx: Int
  let imgURL: String
  let category: String
  let title: String
  let author: String
  let sentence: String
  let comment: String
  let nickname: String
  let date: String
  
  func toDomain() -> FeedDetailModel {
    FeedDetailModel.init(idx:self.idx,
                         imgURL: self.imgURL,
                         category: self.category,
                         title: self.title,
                         author: self.author,
                         sentence: self.sentence,
                         comment: self.comment,
                         nickname: self.nickname,
                         date: self.date)
  }
}
