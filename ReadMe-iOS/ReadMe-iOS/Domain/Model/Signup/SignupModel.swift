//
//  SignupModel.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import Foundation

enum NicknameInvalidType {
  case nicknameDuplicated
  case hasCharacter
  case exceedMaxCount
}

struct SignupDTO {
  let nickname: String
  let platform: String
  let accessToken: String
}

