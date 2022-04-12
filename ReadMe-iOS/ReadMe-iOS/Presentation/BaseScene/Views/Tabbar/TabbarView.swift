//
//  Tabbar.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import UIKit

final class TabbarView: XibView{
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
    currentTab = .home
  }
  
  @IBAction func myPageClicked(_ sender: Any) {
    currentTab = .mypage
  }
  
  private func setTabbarViewModel() {
    homeIcon.viewModel = TabbarIconViewModel(type: .home, clicked: currentTab == .home)
    mypageIcon.viewModel = TabbarIconViewModel(type: .mypage, clicked: currentTab == .mypage)
  }
}
