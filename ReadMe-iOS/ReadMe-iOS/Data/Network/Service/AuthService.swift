//
//  AuthService.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import RxSwift

protocol AuthServiceType {
  func login(provider: String, token: String) -> Observable<LoginEntity?>
  func checkNicknameDuplicated(nickname: String) -> Observable<SignupNicknameEntity?>
  func signup(provider: String, token: String, nickname: String) -> Observable<SignupEntity?>
}

extension BaseService: AuthServiceType {
  func login(provider: String, token: String) -> Observable<LoginEntity?> {
    requestObjectInRx(.postSignin(platform: provider, socialToken: token))
  }
  
  func checkNicknameDuplicated(nickname: String) -> Observable<SignupNicknameEntity?> {
    requestObjectInRx(.getDuplicatedNicknameState(nickname: nickname))
  }
  
  func signup(provider: String, token: String, nickname: String) -> Observable<SignupEntity?> {
    requestObjectInRx(.postSignup(platform: provider, socialToken: token, nickname: nickname))
  }
}
