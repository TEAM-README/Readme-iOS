//
//  WriteSecondFlow.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/21.
//

import UIKit

import SnapKit

class WriteSecondFlow: UIView {
  
  // MARK: - Vars & Lets Part
  private let secondTitleLabel = UILabel()
  private let secondContentTitleLabel = UILabel()
  private let sentenceTextView = UITextView()
  let secondTextView = UITextView()
  
  // MARK: - Life Cycles
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureUI()
    self.setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Custom Methods

extension WriteSecondFlow {
  func setData(bookname: String, sentence: String) {
    
    if bookname.count > 11 {
      let startIndex = bookname.index(bookname.startIndex, offsetBy: 0)
      let endIndex = bookname.index(bookname.startIndex, offsetBy: 10)
      secondContentTitleLabel.text = String(bookname[startIndex..<endIndex]) + "..." + I18N.Write.interestedSentence
    } else {
      secondContentTitleLabel.text = bookname + I18N.Write.interestedSentence
    }
    secondContentTitleLabel.textColor = .mainBlue
    secondContentTitleLabel.setTargetAttributedText(targetString: I18N.Write.interestedSentence, fontType: .semiBold, color: .grey04)
    secondContentTitleLabel.font = .readMeFont(size: 14, type: .semiBold)
    
    sentenceTextView.text = sentence
    sentenceTextView.setTextWithLineHeight(text: sentenceTextView.text, lineHeightMultiple: 1.6)
  }
}


// MARK: - UI & Layout

extension WriteSecondFlow {
  private func configureUI() {
    secondTitleLabel.text = I18N.Write.secondTitle
    secondTitleLabel.font = .readMeFont(size: 16, type: .semiBold)
    secondTitleLabel.textColor = .black
    
    secondTextView.text = I18N.Write.secondPlaceholder
    secondTextView.setTextWithLineHeight(text: secondTextView.text, lineHeightMultiple: 1.6)
    secondTextView.font = .readMeFont(size: 15)
    secondTextView.textColor = .grey09
    
    secondTextView.layer.borderColor = UIColor.grey00.cgColor
    secondTextView.layer.borderWidth = 1
    secondTextView.layer.cornerRadius = 16
    secondTextView.textContainerInset = UIEdgeInsets(top: 18, left: 22, bottom: 18, right: 22)
    
    sentenceTextView.textContainer.maximumNumberOfLines = 4
    sentenceTextView.textContainer.lineBreakMode = .byTruncatingTail
    sentenceTextView.font = .readMeFont(size: 13)
    sentenceTextView.textColor = .grey04
    sentenceTextView.isEditable = false
    sentenceTextView.isSelectable = false
  }
  
  private func setLayout() {
    self.addSubviews([secondTitleLabel, secondContentTitleLabel,
                      secondTextView, sentenceTextView])
    
    secondTitleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalToSuperview().inset(32)
    }
    
    secondTextView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(24)
      make.top.equalTo(secondTitleLabel.snp.bottom).offset(20)
      make.trailing.equalToSuperview().inset(42)
      make.height.equalTo((UIScreen.main.bounds.width - 68) * 0.69)
    }
    
    secondContentTitleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(secondTextView.snp.bottom).offset(28)
      make.trailing.equalToSuperview().inset(28)
    }
    
    sentenceTextView.snp.makeConstraints { make in
      make.leading.equalTo(secondContentTitleLabel.snp.leading)
      make.top.equalTo(secondContentTitleLabel.snp.bottom).offset(14)
      make.trailing.equalTo(secondContentTitleLabel.snp.trailing)
      make.bottom.equalToSuperview()
    }
  }
}