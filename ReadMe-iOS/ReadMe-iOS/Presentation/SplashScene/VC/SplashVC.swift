//
//  SplashVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/13.
//

import UIKit
import RxSwift

class SplashVC: UIViewController {
  @IBOutlet weak var spalshIconView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delayWithSeconds(1) {
      UIView.animate(withDuration: 1.0, delay: 0) {
        if !self.checkOnboardingState() {
          self.spalshIconView.alpha = 0
        }
      } completion: { _ in
        self.processSplashState()
      }
    }
  }
  
  private func checkOnboardingState() -> Bool {
    guard let state = UserDefaults.standard.value(forKey: UserDefaultKeyList.Onboarding.onboardingComplete) as? Bool else { return false }
    return state
  }
  
  private func processSplashState() {
    if !checkOnboardingState() {
      self.pushOnboardingView()
    } else {
      checkLoginState { state in
        switch(state) {
          case .tokenValid    : self.pushBaseView()
          case .tokenMissed   : self.pushLoginView()
          case .tokenInvalid  :
            self.postLogin { loginState in
              loginState ? self.pushBaseView() : self.pushLoginView()
            }
        }
      }
    }
  }
  
  
  
  private func pushLoginView() {
    let loginVC = ModuleFactory.shared.makeLoginVC()
    navigationController?.pushViewController(loginVC, animated: false)
  }
  
  
  private func pushSearchView() {
    let searchVC = ModuleFactory.shared.makeSearchVC()
    navigationController?.pushViewController(searchVC, animated: false)
  }
  
  private func pushBaseView() {
    let baseVC = ModuleFactory.shared.makeBaseVC()
    navigationController?.pushViewController(baseVC, animated: true)
  }
  
  private func pushOnboardingView() {
    let onboardingVC = ModuleFactory.shared.makeOnboardingVC()
    navigationController?.pushViewController(onboardingVC, animated: true)
  }
}

extension SplashVC {
  private func checkLoginState(completion: @escaping ((LoginTokenState) -> Void)) {

    if (UserDefaults.standard.string(forKey: UserDefaultKeyList.Auth.provider) != nil) &&
      (UserDefaults.standard.string(forKey: UserDefaultKeyList.Auth.userToken) != nil) &&
      (UserDefaults.standard.string(forKey: UserDefaultKeyList.Auth.accessToken) != nil){
      
      BaseService.default.getMyFeedListInAF { result in
        result.success { _ in
          completion(.tokenValid)
        }.catch { _ in
          completion(.tokenInvalid)
        }
      }

    } else {
      completion(.tokenMissed)
    }
  }
  
  private func postLogin(completion: @escaping ((Bool) -> Void)) {
    let userToken = UserDefaults.standard.string(forKey: UserDefaultKeyList.Auth.userToken)!
    let provider = UserDefaults.standard.string(forKey: UserDefaultKeyList.Auth.provider)!
    
    BaseService.default.login(provider: provider, token: userToken)
      .subscribe(onNext: { [weak self] loginEntity in
        guard let loginEntity = loginEntity else { return }
        UserDefaults.standard.setValue(loginEntity.user!.id, forKey: UserDefaultKeyList.Auth.userID)
        UserDefaults.standard.setValue(loginEntity.accessToken, forKey: UserDefaultKeyList.Auth.accessToken)
        completion(true)
      },onError: { _ in
        completion(false)
      }).disposed(by: DisposeBag())
  }
}


enum LoginTokenState {
  case tokenValid
  case tokenInvalid
  case tokenMissed
}
