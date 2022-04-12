//
//  Tabbar.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import UIKit

protocol MainTabbarDelegate{
  func tabbarClicked(_ type: TabbarIconType)
}

final class TabbarView: XibView{
  var delegate: MainTabbarDelegate?
  private var currentTab: TabbarIconType = .home {
    didSet{ setTabbarViewModel() }
  }
  
  @IBOutlet weak var homeIcon: TabbarIcon!
  @IBOutlet weak var mypageIcon: TabbarIcon!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setTabbarViewModel()
  }
  
  @IBAction func homeButtonClicked(_ sender: Any) {
    if currentTab != .home{
      delegate?.tabbarClicked(.home)
      currentTab = .home
    }
    
  }
  
  @IBAction func myPageClicked(_ sender: Any) {
    if currentTab != .mypage{
      delegate?.tabbarClicked(.mypage)
      currentTab = .mypage
    }
  }
  
  private func setTabbarViewModel() {
    homeIcon.viewModel = TabbarIconViewModel(type: .home, clicked: currentTab == .home)
    mypageIcon.viewModel = TabbarIconViewModel(type: .mypage, clicked: currentTab == .mypage)
  }
}
