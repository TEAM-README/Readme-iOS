//
//  LoginVC + Kakao.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser

extension LoginVC {
  func kakaoLoginRequest(){
    if (UserApi.isKakaoTalkLoginAvailable()) {
      UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
        guard let self = self else { return }
        self.kakaoLoginRequest(oauthToken,error)
      }
    }
    else { // 카카오톡 설치되지 않음
      UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
        guard let self = self else { return }
        self.kakaoLoginRequest(oauthToken,error)
      }
    }
  }
  
  fileprivate func kakaoLoginRequest(_ oauthToken: OAuthToken? = nil, _ error: Error?) {
    guard (error == nil) else {
      self.loginRequestFail.onNext(.kakao)
      return
    }
    
    guard let token = oauthToken?.accessToken else {
      self.loginRequestFail.onNext(.kakao)
      return
    }

    let authRequestModel = LoginRequestModel(platform: .kakao, platformAccessToken: token)
    self.loginRequest.onNext(authRequestModel)
  }
}
