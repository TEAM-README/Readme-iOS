//
//  LoginVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class LoginVC: UIViewController {
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  var viewModel: LoginViewModel!
  var loginRequestFail = PublishSubject<AuthSignInCase>()
  var loginRequest = PublishSubject<LoginRequestModel>()
  // MARK: - UI Component Part
  @IBOutlet weak var logoCenterYConstraint: NSLayoutConstraint!

  @IBOutlet weak var guideLabel: UILabel!
  @IBOutlet weak var kakaoLoginButton: UIButton!
  @IBOutlet weak var appleLoginButton: UIButton!
  
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setInitialAlpha()
    self.startAlphaAnimation()
    self.startLogoAnimation()
    self.configureLabelUI()
    self.bindViewModels()
  }
}

// MARK: - UI Parts
extension LoginVC {
  private func configureLabelUI() {
    guideLabel.text = I18N.Login.guideText
    guideLabel.textColor = UIColor.grey04
    guideLabel.font = UIFont.readMeFont(size: 15, type: .regular)
    guideLabel.setTargetAttributedText(targetString: I18N.Login.guideEmphasisText, type: .semiBold)
  }
}

// MARK: - Animation Parts
extension LoginVC {
  private func setInitialAlpha() {
    self.guideLabel.alpha = 0
    self.kakaoLoginButton.alpha = 0
    self.appleLoginButton.alpha = 0
  }
  
  private func startAlphaAnimation() {
    UIView.animate(withDuration: 0.9, delay: 1) {
      self.guideLabel.alpha = 1
      self.kakaoLoginButton.alpha = 1
      self.appleLoginButton.alpha = 1
    }
  }
  
  private func startLogoAnimation() {
    logoCenterYConstraint.constant = -88
    UIView.animate(withDuration: 1.2, delay: 0,
                   options: .curveEaseInOut) {
      self.view.layoutIfNeeded()
    }
  }
}

extension LoginVC {
  private func bindViewModels() {
    let input = LoginViewModel.Input(
      loginButtonClicked:Observable.merge(
        self.kakaoLoginButton.rx.tap.map { _ in AuthSignInCase.kakao },
        self.appleLoginButton.rx.tap.map { _ in AuthSignInCase.apple }
      ).asObservable(),
      platformLoginRequestFail: loginRequestFail,
      platformLoginRequestSuccess: loginRequest)
    
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    
    output.loginRequestStart.subscribe(onNext: { [weak self] platform in
      guard let self = self else { return }
      switch(platform) {
        case .kakao: self.kakaoLoginRequest()
        case .apple: self.appleLoginAuthRequest()
      }
    }).disposed(by: self.disposeBag)
    
    output.loginRequestSuccess.subscribe(onNext: { [weak self] platform in
      // 이후 성공했을 시에 넘기기
    }).disposed(by: self.disposeBag)
    
    output.showLoginFailError.subscribe(onNext: { [weak self] platform in
      guard let self = self else { return }
      let msg = platform.getKoreanName() + I18N.Login.loginFailMessage
      self.makeAlert(message: msg)
    }).disposed(by: self.disposeBag)
    
    output.showNetworkError.subscribe(onNext: { [weak self] in
      guard let self = self else { return }
      self.showNetworkErrorAlert()
    }).disposed(by: self.disposeBag)
  }
  
}


