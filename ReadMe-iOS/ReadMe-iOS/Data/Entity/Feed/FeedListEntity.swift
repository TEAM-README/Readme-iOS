//
//  FeedListEntity.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/18.
//

import Foundation

// 임시 Entity고 서버 나온 다음에 다시 수정해야 함
struct FeedListEntity: Codable{
  let category: [FeedCategory]
  let pageNum: Int
  let feedList: [FeedDetailEntity]
  
  func toDomain() -> FeedListModel {
    let feedList = self.feedList.map { entity in
      return FeedDetailModel.init(imgURL: entity.imgURL,
                                  category: entity.category,
                                  title: entity.title,
                                  author: entity.author,
                                  sentence: entity.sentence,
                                  comment: entity.comment,
                                  nickname: entity.nickname,
                                  date: entity.date)
    }
    
    let model = FeedListModel.init(category: self.category,
                                   pageNum: self.pageNum,
                                   feedList: feedList)
    return model
  }
}
