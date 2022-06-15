//
//  FeedModel.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/16.
//

import Foundation

struct FeedDetailModel {
  let idx: Int
  let imgURL: String
  let category: String
  let title: String
  let author: String
  let sentence: String
  let comment: String
  let nickname: String
  let date: String
}

struct FeedListModel {
  let category: [FeedCategory]
  let pageNum: Int
  let feedList: [FeedDetailModel]
}

enum FeedCategory: String,Codable{
  case novel = "소설"
  case essay = "시/에세이"
  case human = "인문"
  case health = "건강"
  case society = "사회"
  case hobby = "취미/레저"
  case history = "역사/문화"
  case travel = "여행/지도"
  case computer = "컴퓨터/IT"
  case magazine = "잡지"
  case comic = "만화"
  case art = "예술/대중문화"
  case selfDevelopment = "자기계발"
  case economic = "경제/경영"
  
  static func getCategory(_ name: String) -> Self {
    if let category = FeedCategory.init(rawValue: name) {
      return category
    } else {
      return FeedCategory.novel
    }
  }
}
