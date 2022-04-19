//
//  FeedListContentTVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/19.
//

import UIKit

struct FeedListContentViewModel {
  let category: String
  let title: String
  let sentence: String
  let sentenceTextViewModel: FeedTextViewModel
  let comment: String
  let commentTextViewModel: FeedTextViewModel
  let nickname: String
  let date: String
}

class FeedListContentTVC: UITableViewCell {
  var viewModel: FeedListContentViewModel? { didSet { bindViewModel() }}
  
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var sentenceTextView: UITextView!
  @IBOutlet weak var commentTextView: UITextView!
  @IBOutlet weak var nicknameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  @IBOutlet weak var sentenceHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var commentHeightConstraint: NSLayoutConstraint!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.configureUI()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
}

extension FeedListContentTVC {
  private func configureUI() {
    categoryLabel.textColor = .mainBlue
    categoryLabel.font = UIFont.readMeFont(size: 14, type: .regular)
    
    titleLabel.textColor = UIColor.init(red: 147/255, green: 147/255, blue: 147/255, alpha: 1)
    titleLabel.font = UIFont.readMeFont(size: 14, type: .medium)
    
    sentenceTextView.textColor = UIColor.grey05
    sentenceTextView.textContainerInset = .zero
    sentenceTextView.textContainer.lineFragmentPadding = 0
    
    commentTextView.textColor = UIColor.black
    commentTextView.textContainer.lineFragmentPadding = 0
    commentTextView.textContainerInset = .zero
    
    nicknameLabel.textColor = UIColor.init(red: 101/255, green: 101/255, blue: 101/255, alpha: 1)
    nicknameLabel.font = UIFont.readMeFont(size: 12, type: .regular)

    dateLabel.textColor = UIColor.grey02
    dateLabel.font = UIFont.readMeFont(size: 12, type: .regular)
  }
  
  private func bindViewModel() {
    guard let viewModel = viewModel else { return }
  }
}
