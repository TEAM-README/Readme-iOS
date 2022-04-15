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
  @IBOutlet weak var commentTextView: UITextView!
  
  @IBOutlet weak var nicknameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var detailButton: UIButton!
  
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
    bookTitleTextView.setTextWithLineHeight(text: "운명을 바꾸는 부동산 투자 수업 운명을 바꾸는 부동산 투자 수업 ...", lineHeight: 1.23)
    bookTitleTextView.font = UIFont.readMeFont(size: 13, type: .medium)
    bookTitleTextView.textColor = UIColor.grey05
    
    authorLabel.font = UIFont.readMeFont(size: 12, type: .regular)
    authorLabel.textColor = UIColor.init(red: 147/255, green: 147/255, blue: 147/255, alpha: 1)
    authorLabel.text = "부동산읽어주는남자(정태익) 저 "
    
    sentenceTextView.textColor = UIColor.grey05
    sentenceTextView.font = UIFont.readMeFont(size: 13, type: .regular)
    sentenceTextView.setTextWithLineHeight(text: "스마트폰보다 재미있는게 있을까\n이것만큼 어려운주제가 없다는 것을 안다. 하지만 그래도\n답하고 싶었던 이유는, \n언제나 카톡 속ㅋㅋㅋ가 아닌,\n실제로 웃을 수 있는 상황을 바랐기 때문이 아닐까", lineHeight: 1.33)
    
    commentTextView.textColor = UIColor.black
    commentTextView.font = UIFont.readMeFont(size: 14, type: .extraLight)
    commentTextView.setTextWithLineHeight(text: "스마트폰보다 재미있는게 있을까\n이것만큼 어려운주제가 없다는 것을 안다. \n하지만 그래도\n답하고 싶었던 이유는, \n언제나 카톡 속ㅋㅋㅋ가 아닌,\n실제로 웃을 수 있는 상황을 바랐기 때문이 아닐까\n하지만 그래도\n답하고 싶었던 이유는, \n언제나 카톡 속ㅋㅋㅋ가 아닌,\n실제로 웃을 수 있는 상황을 바랐기 때문이 아닐까\n하지만 그래도\n답하고 싶었던 이유는, \n언제나 카톡 속ㅋㅋㅋ가 아닌,\n실제로 웃을 수 있는 상황을 바랐기 때문이 아닐까", lineHeight: 1.33)
    
    nicknameLabel.textColor = UIColor.init(red: 101/255, green: 101/255, blue: 101/255, alpha: 1)
    nicknameLabel.font = UIFont.readMeFont(size: 12, type: .regular)

    dateLabel.textColor = UIColor.grey02
    dateLabel.font = UIFont.readMeFont(size: 12, type: .regular)
    
  }
}
