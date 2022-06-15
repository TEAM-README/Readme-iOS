//
//  FeedListEntity.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/18.
//

import Foundation

// 임시 Entity고 서버 나온 다음에 다시 수정해야 함
struct FeedListEntity: Codable{
  let filters: [String]
  let feeds: [FeedDetailEntity]
  
  func toDomain() -> FeedListModel {
    let feedList = self.feeds.map { entity in
      return FeedDetailModel.init(idx: entity.id,
                                  imgURL: entity.image ?? "",
                                  category: entity.categoryName,
                                  title: entity.title,
                                  author: entity.author ?? "",
                                  sentence: entity.sentence,
                                  comment: entity.feeling,
                                  nickname: entity.user.nickname,
                                  date: entity.createdAt)
    }
    
    let category = filters.map { filter in
      return FeedCategory.getCategory(filter)
    }
    
    let model = FeedListModel.init(category: category,
                                   pageNum: 0,
                                   feedList: feedList)
    return model
  }
}

struct MyFeedListEntity: Codable {
  let nickname: String
  let count: Int
  let feeds: [FeedDetailEntity]
  
  func toDomain() -> FeedListModel {
    let feedList = self.feeds.map { entity in
      return FeedDetailModel.init(idx: entity.id,
                                  imgURL: entity.image ?? "",
                                  category: entity.categoryName,
                                  title: entity.title,
                                  author: entity.author ?? "",
                                  sentence: entity.sentence,
                                  comment: entity.feeling,
                                  nickname: entity.user.nickname,
                                  date: entity.createdAt)
    }
    
    let model = FeedListModel.init(category: [],
                                   pageNum: 0,
                                   feedList: feedList)
    return model
  }
}
