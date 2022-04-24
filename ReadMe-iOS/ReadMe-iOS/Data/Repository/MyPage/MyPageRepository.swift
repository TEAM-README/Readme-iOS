//
//  MyPageRepository.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import RxSwift

protocol MyPageRepository {
  func getUserNickname() -> Observable<MyPageEntity?>
}

final class DefaultMyPageRepository {
  
  private let networkService: AuthServiceType
  private let disposeBag = DisposeBag()

  init(service: AuthServiceType) {
    self.networkService = service
  }
}

extension DefaultMyPageRepository: MyPageRepository {
  func getUserNickname() -> Observable<MyPageEntity?> {
    // return networkService.getUserNickname()
    // 서버 개발되면 위 코드 사용 예정
    return getFakeUserNickname()
  }
  
  private func getFakeUserNickname() -> Observable<MyPageEntity?> {
    return .create { observer in
      let myPageEntity = MyPageEntity.init(
        nickname: "혜화동불가마",
        bookCount: 5)
      observer.onNext(myPageEntity)
      return Disposables.create()
    }
  }
}
