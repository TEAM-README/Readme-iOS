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
  func getUserNickname() -> Observable<MyPageEntity?>
}

extension BaseService: AuthServiceType {
  func login(provider: String, token: String) -> Observable<LoginEntity?> {
    requestObjectInRx(.login(provider: provider, token: token))
  }
  
  func checkNicknameDuplicated(nickname: String) -> Observable<Bool?> {
    requestObjectInRx(.postCheckNicknameDuplicated(nickname: nickname))
  }
  
  func getUserNickname() -> Observable<MyPageEntity?> {
    requestObjectInRx(.getNickname)
  }
}
