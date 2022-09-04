//
//  SignupRepository.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import RxSwift

protocol SignupRepository {
  func postNicknameInValidCheck(nickname: String) -> Observable<SignupNicknameEntity?>
  func postUserSignup(data: SignupDTO) -> Observable<SignupEntity?>
}

final class DefaultSignupRepository {
  
  private let networkService: AuthServiceType
  private let disposeBag = DisposeBag()

  init(service: AuthServiceType) {
    self.networkService = service
  }
}

extension DefaultSignupRepository: SignupRepository {
  func postNicknameInValidCheck(nickname: String) -> Observable<SignupNicknameEntity?> {
      return self.networkService.checkNicknameDuplicated(nickname: nickname)

  }
  
  func postUserSignup(data: SignupDTO) -> Observable<SignupEntity?> {
    return self.networkService.signup(provider: data.platform,
                                      token: data.accessToken,
                                      nickname: data.nickname)
  }
}
