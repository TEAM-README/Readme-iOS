//
//  MyPageHeaderTVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/20.
//

import UIKit

struct MyPageHeaderViewModel {
  var nickname: String
  var totalCount: Int
}

class MyPageHeaderTVC: UITableViewCell {
  
  var viewModel: MyPageHeaderViewModel! { didSet { bindViewModel() }}
  
  @IBOutlet weak var nicknameLabel: UILabel!
  @IBOutlet weak var totalCountLabel: UILabel!
  @IBOutlet weak var settingButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.configureUI()
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
    nicknameLabel.setTargetAttributedText(targetString: viewModel.nickname, type: .semiBold)
    
    let countString = String(viewModel.totalCount) + I18N.MyPage.count
    totalCountLabel.text = I18N.MyPage.total + countString + I18N.MyPage.countDescription
    totalCountLabel.setTargetAttributedText(targetString: countString, type: .medium, color: .white)
  }
}
