//
//  LoginVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import UIKit
import RxSwift

class LoginVC: UIViewController {
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  var viewModel: LoginViewModel!
  
  // MARK: - UI Component Part
  @IBOutlet weak var logoCenterYConstraint: NSLayoutConstraint!

  @IBOutlet weak var guideLabel: UILabel!
  @IBOutlet weak var kakaoLoginButton: UIButton!
  @IBOutlet weak var appleLoginButton: UIButton!
  
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setInitialAlpha()
    self.bindViewModels()
    self.startAlphaAnimation()
    self.startLogoAnimation()
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
    UIView.animate(withDuration: 1.5, delay: 0,
                   options: .curveEaseInOut) {
      self.view.layoutIfNeeded()
    }
  }
}

extension LoginVC {
  private func bindViewModels() {
    let input = LoginViewModel.Input()
//    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
  }
}
