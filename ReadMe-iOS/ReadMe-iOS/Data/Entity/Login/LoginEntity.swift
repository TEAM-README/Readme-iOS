//
//  LoginEntity.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import Foundation

struct LoginEntity: Codable {
    let isNewUser: Bool
    let user: LoginUserData?
    let accessToken: String?
}

// MARK: - User
struct LoginUserData: Codable {
    let id: Int
    let nickname: String
}

struct LoginHistoryData: Codable{
  let platform: String
  let accesToken: String
}
