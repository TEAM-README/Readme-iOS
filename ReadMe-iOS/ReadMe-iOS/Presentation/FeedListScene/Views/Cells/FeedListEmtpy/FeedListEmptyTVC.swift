//
//  FeedListEmptyTVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/05/07.
//

import UIKit

final class FeedListEmptyTVC: UITableViewCell, UITableViewRegisterable {
  static let isFromNib: Bool = true
  var isMyPage: Bool = false { didSet{ configureUI() }}
  var cellHeight: CGFloat = 500 { didSet{ setHeight() }}
  @IBOutlet weak var topDescriptionLabel: UILabel!
  @IBOutlet weak var bottomDescriptionLabel: UILabel!
  
  @IBOutlet weak var topConstraint: NSLayoutConstraint!
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

extension FeedListEmptyTVC {
  private func configureUI() {
    topDescriptionLabel.font = .readMeFont(size: 16, type: .medium)
    topDescriptionLabel.textColor = .grey02
    topDescriptionLabel.text = isMyPage ? I18N.MyPage.emptyTopDescription : I18N.FeedList.emptyTopDescription
    
    bottomDescriptionLabel.font = . readMeFont(size: 14, type: .regular)
    bottomDescriptionLabel.textColor = .grey02
    bottomDescriptionLabel.text = isMyPage ? I18N.MyPage.emptyBottomDescription : I18N.FeedList.emptyBottomDescription
    
  }
  
  private func setHeight() {
    let blankHeight = cellHeight - 49
    bottomConstraint.constant = blankHeight / 2 + 15
    topConstraint.constant = blankHeight / 2 - 15
    self.layoutIfNeeded()
  }
}
