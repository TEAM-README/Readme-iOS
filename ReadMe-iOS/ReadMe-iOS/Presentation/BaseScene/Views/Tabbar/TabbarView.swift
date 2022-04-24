//
//  Tabbar.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import UIKit

protocol MainTabbarDelegate{
  func tabbarClicked(_ type: TabbarIconType)
	func plusButtonClicked()
}

final class TabbarView: XibView{
  var delegate: MainTabbarDelegate?
  private var currentTab: TabbarIconType = .home {
    didSet{ setTabbarViewModel() }
  }
  
  @IBOutlet weak var homeIcon: TabbarIcon!
  @IBOutlet weak var mypageIcon: TabbarIcon!
  @IBOutlet weak var plusButton: UIButton!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setTabbarViewModel()
  }
  
  @IBAction func homeButtonClicked(_ sender: Any) {
    makeVibrate()
    if currentTab != .home{
      delegate?.tabbarClicked(.home)
      currentTab = .home
		} else {
			postObserverAction(.homeButtonClicked)
		}
  }
  
  @IBAction func myPageClicked(_ sender: Any) {
    makeVibrate()
    if currentTab != .mypage{
      delegate?.tabbarClicked(.mypage)
      currentTab = .mypage
		} else {
			postObserverAction(.mypageButtonClicked)
		}
  }
    
  @IBAction func plusButtonClicked(_ sender: Any) {
    makeVibrate()
		delegate?.plusButtonClicked()
  }
    
  private func setTabbarViewModel() {
    homeIcon.viewModel = TabbarIconViewModel(type: .home, clicked: currentTab == .home)
    mypageIcon.viewModel = TabbarIconViewModel(type: .mypage, clicked: currentTab == .mypage)
  }
}
