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
    delayWithSeconds(2) {
      self.pushLoginView()
    }
  }
  
  private func pushLoginView() {
    let loginVC = ModuleFactory.shared.makeLoginVC()
    navigationController?.pushViewController(loginVC, animated: false)
  }
}
