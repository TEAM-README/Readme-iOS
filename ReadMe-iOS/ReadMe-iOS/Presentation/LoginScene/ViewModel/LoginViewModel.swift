//
//  LoginViewModel.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import RxSwift
import RxRelay

final class LoginViewModel: ViewModelType {

  private let useCase: LoginUseCase
  private let disposeBag = DisposeBag()
  
  // MARK: - Inputs
  struct Input {
    let loginButtonClicked: Observable<AuthSignInCase>
    let platformLoginRequestFail: Observable<AuthSignInCase>
    let platformLoginRequestSuccess: Observable<LoginRequestModel>
  }
  
  // MARK: - Outputs
  struct Output {
    var loginRequestStart = PublishRelay<AuthSignInCase>()
    var loginRequestSuccess = PublishRelay<AuthSignInCase>()
    var signupRequired = PublishRelay<LoginHistoryData>()
    var showLoginFailError = PublishRelay<AuthSignInCase>()
    var showNetworkError = PublishRelay<Void>()
  }
  
  init(useCase: LoginUseCase) {
    self.useCase = useCase
  }
}

extension LoginViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)

    input.loginButtonClicked
      .subscribe(onNext: { platform in
        output.loginRequestStart.accept(platform)
      }).disposed(by: self.disposeBag)
    
    input.platformLoginRequestSuccess
      .subscribe(onNext: { [weak self] loginRequest in
        guard let self = self else { return }
        self.useCase.userSignIn(platform: loginRequest.platform, token: loginRequest.platformAccessToken)
      }).disposed(by: self.disposeBag)
    
    input.platformLoginRequestFail
      .subscribe(onNext: { platform in
        output.showLoginFailError.accept(platform)

      }).disposed(by: self.disposeBag)
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    let loginRelay = useCase.loginData
    let signupRequired = useCase.signupRequired
    let loginError = useCase.loginFail
    
    loginRelay.subscribe(onNext: { loginData in
      output.loginRequestSuccess.accept(loginData.platform)
    }).disposed(by: self.disposeBag)
    
    signupRequired.subscribe(onNext: { loginData in
      let historyData = LoginHistoryData(platform: loginData.platform.rawValue,
                                         accesToken: loginData.accessToken)
      output.signupRequired.accept(historyData)
    }).disposed(by: self.disposeBag)
    
    loginError.subscribe(onNext: { _ in
      output.showNetworkError.accept(())
    }).disposed(by: self.disposeBag)
    
  }
}
