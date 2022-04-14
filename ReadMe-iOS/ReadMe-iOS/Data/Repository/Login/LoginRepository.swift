//
//  LoginRepository.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import RxSwift

protocol LoginRepository {
  func postUserSignIn(provider: String, token: String) -> Observable<LoginEntity?>
}

final class DefaultLoginRepository {
  
  private let networkService: AuthServiceType // 추후 변경해야 함
  private let disposeBag = DisposeBag()

  init(service: AuthServiceType) {
    self.networkService = service
  }
}

extension DefaultLoginRepository: LoginRepository {
  func postUserSignIn(provider: String, token: String) -> Observable<LoginEntity?> {
    return .create { observer in
      self.networkService.login(provider: provider, token: token)
        .subscribe(onNext: { entity in
          guard let entity = entity else {return observer.onCompleted()}
          observer.onNext(entity)
        }, onError: {err in
          observer.onError(err)
        })
        .disposed(by: self.disposeBag)
      return Disposables.create()
    }
  }
}
