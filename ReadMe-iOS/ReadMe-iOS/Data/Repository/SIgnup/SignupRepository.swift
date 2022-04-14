//
//  SignupRepository.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import RxSwift

protocol SignupRepository {
  func postNicknameValidCheck(nickname: String) -> Observable<Bool?>
}

final class DefaultSignupRepository {
  
  private let networkService: AuthServiceType
  private let disposeBag = DisposeBag()

  init(service: AuthServiceType) {
    self.networkService = service
  }
}

extension DefaultSignupRepository: SignupRepository {
  func postNicknameValidCheck(nickname: String) -> Observable<Bool?> {
    //  return self.networkService.checkNicknameDuplicated(nickname: nickname)
    //  이후 실제로 쓸 코드 잠시 주석처리 해둠 (서버 되면 붙일 예정)
    
    // 닉네임 중복 검사를 잠시 임시로 처리해둠
    return .create { observer in
      if nickname == "혜화동불가마" || nickname == "혜화동" {
        observer.onNext(false)
      }else {
        observer.onNext(true)
      }
      return Disposables.create()
    }
  }

}
