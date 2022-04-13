//
//  AuthService.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import RxSwift

protocol AuthServiceType {
  func login(provider: String, token: String) -> Observable<LoginEntity?>
}

extension BaseService: AuthServiceType {
  func login(provider: String, token: String) -> Observable<LoginEntity?> {
    requestObjectInRx(.login(provider: provider, token: token))
  }
}
