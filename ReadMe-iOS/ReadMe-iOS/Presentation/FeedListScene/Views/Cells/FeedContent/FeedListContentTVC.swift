//
//  FeedListContentTVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/19.
//

import UIKit

struct FeedListContentViewModel: FeedListDataSource {
  let category: String
  let title: String
  let sentenceTextViewModel: FeedTextViewModel
  let commentTextViewModel: FeedTextViewModel
  let nickname: String
  let date: String
  let isMyPage: Bool
}

final class FeedListContentTVC: UITableViewCell, UITableViewRegisterable {
  static var isFromNib: Bool = true
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
    sentenceTextView.textContainer.maximumNumberOfLines = 4
    sentenceTextView.textContainer.lineBreakMode = .byTruncatingTail
    
    commentTextView.textColor = UIColor.black
    commentTextView.textContainer.lineFragmentPadding = 0
    commentTextView.textContainerInset = .zero
    commentTextView.textContainer.maximumNumberOfLines = 6
    commentTextView.textContainer.lineBreakMode = .byTruncatingTail
    
    nicknameLabel.textColor = UIColor.init(red: 101/255, green: 101/255, blue: 101/255, alpha: 1)
    nicknameLabel.font = UIFont.readMeFont(size: 12, type: .regular)

    dateLabel.textColor = UIColor.grey02
    dateLabel.font = UIFont.readMeFont(size: 12, type: .regular)
  }
  
  private func bindViewModel() {
    guard let viewModel = viewModel else { return }
    contentView.backgroundColor = viewModel.isMyPage ? .mainBlue : .grey00
    categoryLabel.text = viewModel.category
    titleLabel.text = viewModel.title
    nicknameLabel.text = viewModel.nickname
    dateLabel.text = viewModel.date
    
    sentenceTextView.setTextWithLineHeight(
      text: viewModel.sentenceTextViewModel.content,
      lineHeightMultiple: viewModel.sentenceTextViewModel.lineHeightMultiple)
    sentenceTextView.setCharacterSpacing(kernValue: -0.1)
    sentenceTextView.font = viewModel.sentenceTextViewModel.textFont
    sentenceHeightConstraint.constant = viewModel.sentenceTextViewModel.textViewHeight
    sentenceTextView.sizeToFit()
    
    commentTextView.setTextWithLineHeight(
      text: viewModel.commentTextViewModel.content,
      lineHeightMultiple: viewModel.commentTextViewModel.lineHeightMultiple)
    sentenceTextView.setCharacterSpacing(kernValue: -0.2)
    commentTextView.font = viewModel.commentTextViewModel.textFont
    commentHeightConstraint.constant = viewModel.commentTextViewModel.textViewHeight
    commentTextView.sizeToFit()
  }
}
