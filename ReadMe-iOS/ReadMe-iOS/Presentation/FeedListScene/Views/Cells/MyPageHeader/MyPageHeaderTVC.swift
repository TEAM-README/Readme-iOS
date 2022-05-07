//
//  MyPageHeaderTVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/20.
//

import UIKit

final class MyPageHeaderTVC: UITableViewCell, UITableViewRegisterable {
  
  static var isFromNib: Bool = true
  var viewModel: MyPageModel! { didSet { bindViewModel() }}
  
  @IBOutlet weak var nicknameLabel: UILabel!
  @IBOutlet weak var totalCountLabel: UILabel!
  @IBOutlet weak var settingButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.configureUI()
    self.setButtonAction()
  }
  
}

extension MyPageHeaderTVC {
  private func configureUI() {
    nicknameLabel.textColor = .white
    nicknameLabel.font = .readMeFont(size: 20, type: .light)
    
    totalCountLabel.textColor = .init(white: 1, alpha: 0.6)
    totalCountLabel.font = .readMeFont(size: 14, type: .medium)
  }
  
  private func bindViewModel() {
    guard let viewModel = viewModel else { return }
    nicknameLabel.text = viewModel.nickname + I18N.MyPage.nicknameDescription
    nicknameLabel.setTargetAttributedText(targetString: viewModel.nickname, fontType: .semiBold)
    
    let countString = String(viewModel.bookCount) + I18N.MyPage.count
    totalCountLabel.text = I18N.MyPage.total + countString + I18N.MyPage.countDescription
    totalCountLabel.setTargetAttributedText(targetString: countString, fontType: .medium, color: .white)
  }
  
  private func setButtonAction() {
    settingButton.press {
      self.postObserverAction(.moveSettingView)
    }
  }
}
