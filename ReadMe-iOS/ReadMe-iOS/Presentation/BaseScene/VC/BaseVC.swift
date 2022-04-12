//
//  BaseVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import UIKit

class BaseVC: UIViewController {
  // MARK: - Vars & Lets Part

  // MARK: - UI Component Part
  @IBOutlet weak var sceneContainerView: UIView!
  @IBOutlet weak var tabbar: TabbarView!
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTabbarDelegate()
  }
}

// MARK: - 탭바를 제외한 Scene 세팅하는 부분

extension BaseVC: MainTabbarDelegate{
  private func configureTabbarDelegate(){
    tabbar.delegate = self
  }
  
  func tabbarClicked(_ type: TabbarIconType) {
    
  }
  
  private func setScene(_ type: TabbarIconType) {
    
  }
  
  private func makeViewControllers(
}


