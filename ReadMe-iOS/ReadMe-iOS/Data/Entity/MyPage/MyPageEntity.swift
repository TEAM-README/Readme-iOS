//
//  MyPageEntity.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import Foundation

struct MyPageEntity: Codable{
  let nickname: String
  let bookCount: Int
  
  func toDomain() -> MyPageModel {
    MyPageModel(nickname: self.nickname,
                bookCount: self.bookCount)
  }
}
