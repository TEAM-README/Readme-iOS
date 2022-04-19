//
//  SplashVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/13.
//

import UIKit

class SplashVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delayWithSeconds(1) {
//      self.pushSignupView()
      self.pushWriteView()
    }
    
    
  }
  
  private func pushLoginView() {
    let loginVC = ModuleFactory.shared.makeLoginVC()
    navigationController?.pushViewController(loginVC, animated: false)
  }
  
  private func pushSignupView() {
    let signupVC = ModuleFactory.shared.makeSignupVC()
    navigationController?.pushViewController(signupVC, animated: false)
  }
  
  private func pushWriteView() {
    let writeVC = ModuleFactory.shared.makeWriteVC()
    navigationController?.pushViewController(writeVC, animated: false)
  }
}
