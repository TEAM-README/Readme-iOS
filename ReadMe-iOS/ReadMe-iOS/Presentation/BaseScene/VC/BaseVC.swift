//
//  BaseVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import UIKit
import SnapKit

class BaseVC: UIViewController {
  // MARK: - Vars & Lets Part
  private let moduleFactory = ModuleFactory.shared
  private var tabList: [TabbarIconType] = []

  // MARK: - UI Component Part
  @IBOutlet weak var sceneContainerView: UIView!
  @IBOutlet weak var tabbar: TabbarView!
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTabbarDelegate()
    tabbarClicked(.home)
  }
}

// MARK: - 탭바를 제외한 Scene 세팅하는 부분

extension BaseVC: MainTabbarDelegate{
  private func configureTabbarDelegate(){
    tabbar.delegate = self
  }
  
  func tabbarClicked(_ type: TabbarIconType) {
    if !tabList.contains(type){
      let vc = makeScene(type)
      vc.view.translatesAutoresizingMaskIntoConstraints = false
      self.addChild(vc)
      sceneContainerView.addSubview(vc.view)
      vc.view.snp.makeConstraints{ $0.edges.equalToSuperview() }
      vc.didMove(toParent: self)
      tabList.append(type)
    }else {
      let vc = sceneContainerView.subviews.first!
      sceneContainerView.bringSubviewToFront(vc)
    }
  }
  
  private func makeScene(_ type: TabbarIconType) -> UIViewController{
    switch(type) {
      case .home: return moduleFactory.makeHomeVC()
      case .mypage: return moduleFactory.makeMyPageVC()
    }
  }
}


