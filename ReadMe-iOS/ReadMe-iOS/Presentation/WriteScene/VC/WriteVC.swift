//
//  WriteVC.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/19.
//

import UIKit

import SnapKit

@frozen
enum flowType {
  case firstFlow
  case secondFlow
}

class WriteVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  private let topBgView = UIView()
  private let cheerLabel = UILabel()
  private let describeLabel = UILabel()
  private let titleLabel = UILabel()
  private let writeTextView = UITextView()
  private let nextButton = BottomButton()
  
  private let firstView = UIView()
  private let firstTitleLabel = UILabel()
  private let bookCoverImageView = UIImageView()
  private let categoryLabel = UILabel()
  private let bookTitleLabel = UILabel()
  private let bookAuthorLabel = UILabel()
  
  private let secondView = UIView()
  private let secondTitleLabel = UILabel()
  private let sentenceTextView = UITextView()
  
  let username: String = "혜화동 꽃가마"
  let bookname: String = "바람이분다어쩌고저쩌고뭐?" // 11글자 초과면 끝에 자르기
  
  lazy var progressView = UIProgressView()
  var viewModel: WriteViewModel!
  
  // MARK: - Vars & Lets Part
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    setLayout()
  }
}

// MARK: - UI & Layout Part

extension WriteVC {
  private func configureUI() {
    topBgView.backgroundColor = .grey07
    
    progressView.progressTintColor = .pointBlue
    progressView.trackTintColor = .grey01
    progressView.progress = 0.5
    
    cheerLabel.text = username + I18N.Write.startCheer
    cheerLabel.font = .readMeFont(size: 14, type: .bold)
    cheerLabel.textColor = .mainBlue
    cheerLabel.setTextWithLineHeight(text: cheerLabel.text, lineHeightMultiple: 1.6)
    cheerLabel.setTargetAttributedText(targetString: I18N.Write.startCheer, fontType: .regular, color: .grey08)
    
    describeLabel.text = I18N.Write.startDescribe
    describeLabel.font = .readMeFont(size: 14, type: .regular)
    describeLabel.textColor = .grey08
    describeLabel.numberOfLines = 2
    describeLabel.setTextWithLineHeight(text: I18N.Write.startDescribe, lineHeightMultiple: 1.6)
    
    titleLabel.text = I18N.Write.firstTitle
    titleLabel.font = .readMeFont(size: 16, type: .semiBold)
    titleLabel.textColor = .black
    
    writeTextView.setTextWithLineHeight(text: writeTextView.text, lineHeightMultiple: 1.6)
    writeTextView.text = I18N.Write.firstPlaceholder
    writeTextView.font = .readMeFont(size: 15)
    writeTextView.textColor = .grey09
    writeTextView.layer.borderColor = UIColor.grey00.cgColor
    writeTextView.layer.borderWidth = 1
    writeTextView.layer.cornerRadius = 16
    writeTextView.textContainerInset = UIEdgeInsets(top: 18, left: 22, bottom: 18, right: 22)
    
    nextButton.title = I18N.Write.next
    nextButton.isEnabled = true
    
    firstTitleLabel.text = I18N.Write.selectedBook
    firstTitleLabel.font = .readMeFont(size: 14, type: .medium)
    firstTitleLabel.textColor = .black
    firstTitleLabel.setTextWithLineHeight(text: firstTitleLabel.text, lineHeightMultiple: 1.5)
    
    bookCoverImageView.backgroundColor = .alertRed
    
    categoryLabel.text = "엥 그래요?"
    categoryLabel.font = .readMeFont(size: 12)
    categoryLabel.textColor = .mainBlue
    categoryLabel.setTextWithLineHeight(text: categoryLabel.text, lineHeightMultiple: 1.0)
    
    bookTitleLabel.text = "운명을 바꾸는 부동산 투자 수업 운명을 바꾸는 부동산 투자 수업 ..."
    bookTitleLabel.font = .readMeFont(size: 13, type: .medium)
    bookTitleLabel.textColor = .grey05
    bookTitleLabel.setTextWithLineHeight(text: bookTitleLabel.text, lineHeightMultiple: 1.48)
    bookTitleLabel.numberOfLines = 2
    
    bookAuthorLabel.text = "부동산읽어주는남자(정태익) 저 "
    bookAuthorLabel.font = .readMeFont(size: 12)
    bookAuthorLabel.textColor = .grey06
    bookAuthorLabel.setTextWithLineHeight(text: bookAuthorLabel.text, lineHeightMultiple: 1.0)
    
    secondTitleLabel.text = bookname + I18N.Write.interestedSentence
    secondTitleLabel.textColor = .mainBlue
    secondTitleLabel.setTargetAttributedText(targetString: I18N.Write.interestedSentence, fontType: .semiBold, color: .grey04)
    secondTitleLabel.font = .readMeFont(size: 14, type: .semiBold)
    
    sentenceTextView.text = "‘스마트폰보다 재미있는 게 있을까' 이것만큼 어려운 주제가 없다는 것을 안다. 하지만 그래도 답하고 싶었던 이유는, 언제나 카톡 속 ㅋㅋㅋ가 아닌, 실제로 웃을 수 있는 상황을 바랐기 때문이 아닐까"
    sentenceTextView.setTextWithLineHeight(text: sentenceTextView.text, lineHeightMultiple: 1.6)
    sentenceTextView.font = .readMeFont(size: 13)
    sentenceTextView.textColor = .grey04
    
    // TODO: - 플로우에 따라 ui 분기처리 + textview layout 변경
    secondView.isHidden = true
  }
  
  private func setFirstFlow() {
    
  }
  
  private func setSecondFlow() {
    
  }
  
  private func setLayout() {
    view.addSubviews([topBgView, cheerLabel, describeLabel,
                     titleLabel, writeTextView, progressView,
                      firstView, secondView, nextButton])
    
    cheerLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
    }
    
    describeLabel.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(28)
      make.top.equalTo(cheerLabel.snp.bottom).offset(16)
    }
    
    topBgView.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview()
      make.bottom.equalTo(describeLabel.snp.bottom).offset(32)
    }
    
    progressView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(topBgView.snp.bottom)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(topBgView.snp.bottom).offset(32)
    }
    
    writeTextView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(24)
      make.top.equalTo(titleLabel.snp.bottom).offset(20)
      make.trailing.equalToSuperview().inset(42)
      make.height.equalTo((UIScreen.main.bounds.width - 68) * 0.61)
    }
    
    nextButton.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(22)
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(34)
      make.height.equalTo(nextButton.snp.width).multipliedBy(0.156)
    }
    
    firstView.addSubviews([firstTitleLabel, bookCoverImageView, categoryLabel,
                          bookTitleLabel, bookAuthorLabel])
    
    firstView.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      make.top.equalTo(writeTextView.snp.bottom).offset(37)
    }
    
    firstTitleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalToSuperview()
    }
    
    bookCoverImageView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(firstTitleLabel.snp.bottom).offset(18)
      make.height.equalTo(82)
      make.width.equalTo(bookCoverImageView.snp.height).multipliedBy(0.68)
    }
    
    categoryLabel.snp.makeConstraints { make in
      make.leading.equalTo(bookCoverImageView.snp.trailing).offset(22)
      make.top.equalTo(bookCoverImageView.snp.top)
    }
    
    bookTitleLabel.snp.makeConstraints { make in
      make.leading.equalTo(categoryLabel.snp.leading)
      make.top.equalTo(categoryLabel.snp.bottom).offset(6)
      make.trailing.equalToSuperview().inset(57)
    }
    
    bookAuthorLabel.snp.makeConstraints { make in
      make.leading.equalTo(categoryLabel.snp.leading)
      make.top.equalTo(bookTitleLabel.snp.bottom).offset(14)
      make.trailing.equalTo(bookTitleLabel.snp.trailing)
    }
    
    secondView.addSubviews([secondTitleLabel, sentenceTextView])
    
    secondView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.trailing.equalToSuperview().inset(46)
      make.top.equalTo(writeTextView.snp.bottom).offset(28)
      make.bottom.equalTo(nextButton.snp.top).offset(61)
    }
    
    secondTitleLabel.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview()
    }
    
    sentenceTextView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      make.top.equalTo(secondTitleLabel.snp.bottom).offset(14)
    }
  }
}
