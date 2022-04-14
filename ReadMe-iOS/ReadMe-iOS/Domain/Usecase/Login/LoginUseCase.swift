//
//  LoginUseCase.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import RxSwift

protocol LoginUseCase {
  func userSignIn(platform: AuthSignInCase, token: String)
  var loginData: PublishSubject<LoginModel> { get set }
  var loginFail: PublishSubject<Error> { get set }
}

final class DefaultLoginUseCase {
  
  private let repository: LoginRepository
  private let disposeBag = DisposeBag()
  
  var loginData = PublishSubject<LoginModel>()
  var loginFail = PublishSubject<Error>()
  
  init(repository: LoginRepository) {
    self.repository = repository
  }
}

extension DefaultLoginUseCase: LoginUseCase {
  func userSignIn(platform: AuthSignInCase, token: String){
    repository.postUserSignIn(provider: platform.rawValue, token: token)
      .subscribe(onNext: { [weak self] entity in
        guard let self = self else {return}
        guard let token = entity?.accessToken else {return}
        UserDefaults.standard.setValue(platform.rawValue, forKeyPath: UserDefaultKeyList.Auth.provider)
        UserDefaults.standard.setValue(token, forKeyPath: UserDefaultKeyList.Auth.userToken)
        let data = LoginModel(platform: platform, accessToken: token)
        self.loginData.onNext(data)
      },onError: { err in
        self.loginFail.onNext(err)
      }).disposed(by: self.disposeBag)
  }
}
