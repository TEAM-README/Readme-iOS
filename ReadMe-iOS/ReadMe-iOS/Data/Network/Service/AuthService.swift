//
//  AuthService.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import RxSwift

protocol AuthServiceType {
  func login(provider: String, token: String) -> Observable<LoginEntity?>
  func checkNicknameDuplicated(nickname: String) -> Observable<Bool?>
}

extension BaseService: AuthServiceType {
  func login(provider: String, token: String) -> Observable<LoginEntity?> {
    requestObjectInRx(.postSignin(platform: provider, socialToken: token))
  }
  
  func checkNicknameDuplicated(nickname: String) -> Observable<Bool?> {
    requestObjectInRx(.getDuplicatedNicknameState(nickname: nickname))
  }
}
