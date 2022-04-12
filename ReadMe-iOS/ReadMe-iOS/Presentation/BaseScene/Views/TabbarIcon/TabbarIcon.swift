//
//  TabbarIcon.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import UIKit

enum TabbarIconType {
  case home
  case mypage
}

struct TabbarIconViewModel {
  var type: TabbarIconType
  var clicked: Bool
}

final class TabbarIcon: XibView{
  
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var iconTitleLabel: UILabel!
  
  var viewModel: TabbarIconViewModel? {
    didSet{
      configureUI()
    }
  }

  private func configureUI() {
    guard let viewModel = viewModel else { return }
    iconTitleLabel.font = .readMeFont(size: 12, type: .medium)
    iconTitleLabel.setCharacterSpacing(kernValue: -0.6)
    switch(viewModel.type){
      case .home:
        iconImageView.image =
        viewModel.clicked ? ImageLiterals.TabBar.homeSelected : ImageLiterals.TabBar.home
        iconTitleLabel.text = I18N.Tabbar.home
        
      case .mypage:
        iconImageView.image =
        viewModel.clicked ? ImageLiterals.TabBar.mypageSelected : ImageLiterals.TabBar.mypage
        iconTitleLabel.text = I18N.Tabbar.mypage
    }
  }
}

