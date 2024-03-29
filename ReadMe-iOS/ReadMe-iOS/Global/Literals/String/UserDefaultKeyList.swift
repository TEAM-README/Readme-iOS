//
//  UserDefaultKeyList.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/13.
//

import Foundation

struct UserDefaultKeyList{
  
  struct Onboarding {
    static let onboardingComplete = "onboardingComplete"
  }
  struct Auth {
    static let provider = "loginProvider"
    static let userToken = "userToken"
    static let userID = "userID"
    static let accessToken = "accessToken"
    static let userNickname = "userNickname"
  }
}
