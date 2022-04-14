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
      self.pushLoginView()
    }
    
    
    for family in UIFont.familyNames {
      print("\(family)");
      for names in UIFont.fontNames(forFamilyName: family) {
        print("== \(names)");
      }
    }
    
    
  }
  
  private func pushLoginView() {
    let loginVC = ModuleFactory.shared.makeLoginVC()
    navigationController?.pushViewController(loginVC, animated: false)
  }
}
