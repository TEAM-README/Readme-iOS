//
//  SignupEntity.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import Foundation

// MARK: - DataClass
struct SignupEntity: Codable {
    let user: SignupUserData
    let accessToken: String
}

// MARK: - User
struct SignupUserData: Codable {
    let id: Int
    let nickname: String
}

struct SignupNicknameEntity: Codable {
  let available: Bool
}
