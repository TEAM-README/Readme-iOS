//
//  LoginModel.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import Foundation

enum AuthSignInCase: String {
  case kakao
  case apple
  
  func getKoreanName() -> String{
    switch self{
      case .kakao: return I18N.Login.kakao
      case .apple: return I18N.Login.apple
    }
  }
}

struct LoginModel {
  var platform: AuthSignInCase
  let accessToken: String
}

struct LoginRequestModel {
  var platform: AuthSignInCase
  var platformAccessToken: String
}
