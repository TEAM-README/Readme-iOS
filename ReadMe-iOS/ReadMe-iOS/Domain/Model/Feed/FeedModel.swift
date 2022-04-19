//
//  FeedModel.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/16.
//

import Foundation

struct FeedDetailModel: Codable {
  let imgURL: String
  let category: String
  let title: String
  let author: String
  let sentence: String
  let comment: String
  let nickname: String
  let date: String
}

struct FeedListModel: Codable {
  let category: [FeedCategory]
  let pageNum: Int
  let feedList: [FeedDetailModel]
}

enum FeedCategory: String,Codable{
  case novel = "소설"
  case essay = "시/에세이"
  case human = "인문"
  case home = "가정/생활/요리"
  case health = "건강"
  case hobby = "취미/레저"
  case economy = "경제/경영"
  case comic = "만화"
}
