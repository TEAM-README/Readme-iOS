//
//  FeedDetailVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/16.
//

import UIKit
import RxSwift

class FeedDetailVC: UIViewController {
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  var viewModel: FeedDetailViewModel!
  
  // MARK: - UI Component Part
  @IBOutlet weak var bookCoverImageView: UIImageView!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var bookTitleTextView: UITextView!
  @IBOutlet weak var authorLabel: UILabel!
  
  @IBOutlet weak var sentenceTextView: UITextView!
  @IBOutlet weak var seperatorLine: UIView!
  @IBOutlet weak var commentTextView: UITextView!
  
  @IBOutlet weak var nicknameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var detailButton: UIButton!
  
  @IBOutlet weak var sentenceHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var commentHeightConstraint: NSLayoutConstraint!
  
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
//    self.bindViewModels()
    self.configureUI()
  }
}

extension FeedDetailVC {
  
  // MARK: - Custom Method Part
  private func bindViewModels() {
    let input = FeedDetailViewModel.Input()
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
  }
}


extension FeedDetailVC {
  private func configureUI() {
    bookCoverImageView.layer.cornerRadius = 2
    
    categoryLabel.textColor = .mainBlue
    categoryLabel.font = UIFont.readMeFont(size: 12, type: .regular)
    categoryLabel.text = "경제/경영"
    
    bookTitleTextView.textContainerInset = .zero
    bookTitleTextView.textContainer.lineFragmentPadding = 0
    bookTitleTextView.setTextWithLineHeight(text: "운명을 바꾸는 부동산 투자 수업 운명을 바꾸는 부동산 투자 수업 ...", lineHeightMultiple: 1.23)
    bookTitleTextView.font = UIFont.readMeFont(size: 13, type: .medium)
    bookTitleTextView.textColor = UIColor.grey05
    
    authorLabel.font = UIFont.readMeFont(size: 12, type: .regular)
    authorLabel.textColor = UIColor.init(red: 147/255, green: 147/255, blue: 147/255, alpha: 1)
    authorLabel.text = "부동산읽어주는남자(정태익) 저 "
    
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
    
    sentenceHeightConstraint.constant = 300
    commentHeightConstraint.constant = 1000
    self.view.layoutIfNeeded()
    
  }
}
