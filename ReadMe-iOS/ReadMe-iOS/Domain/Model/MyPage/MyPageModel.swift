//
//  MyPageModel.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import Foundation

struct MyPageModel: Codable, FeedListDataSource{
  let nickname: String
  let bookCount: Int
}
