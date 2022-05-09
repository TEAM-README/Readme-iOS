//
//  WriteImpressionFlow.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/21.
//

import UIKit

import SnapKit

final class WriteImpressionFlow: UIView {
  
  // MARK: - Vars & Lets Part
  private let titleLabel = UILabel()
  private let contentTitleLabel = UILabel()
  private let quoteTextView = UITextView()
  let impressionTextView = UITextView()
  
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

extension WriteImpressionFlow {
  func setData(bookname: String, sentence: String) {
    
    if bookname.count > 11 {
      let startIndex = bookname.index(bookname.startIndex, offsetBy: 0)
      let endIndex = bookname.index(bookname.startIndex, offsetBy: 10)
      contentTitleLabel.text = String(bookname[startIndex..<endIndex]) + "..." + I18N.Write.interestedSentence
    } else {
      contentTitleLabel.text = bookname + I18N.Write.interestedSentence
    }
    contentTitleLabel.textColor = .mainBlue
    contentTitleLabel.setTargetAttributedText(targetString: I18N.Write.interestedSentence, fontType: .semiBold, color: .grey04)
    contentTitleLabel.font = .readMeFont(size: 14, type: .semiBold)
    
    quoteTextView.text = sentence
    quoteTextView.setTextWithLineHeight(text: quoteTextView.text, lineHeightMultiple: 1.33)
  }
}


// MARK: - UI & Layout

extension WriteImpressionFlow {
  private func configureUI() {
    titleLabel.text = I18N.Write.impressionTitle
    titleLabel.font = .readMeFont(size: 16, type: .semiBold)
    titleLabel.textColor = .black
    
    impressionTextView.text = I18N.Write.impressionPlaceholder
    impressionTextView.setTextWithLineHeight(text: impressionTextView.text, lineHeightMultiple: 1.33)
    impressionTextView.font = .readMeFont(size: 15)
    impressionTextView.textColor = .grey09
    
    impressionTextView.layer.borderColor = UIColor.grey00.cgColor
    impressionTextView.layer.borderWidth = 1
    impressionTextView.layer.cornerRadius = 16
    impressionTextView.textContainerInset = UIEdgeInsets(top: 18, left: 22, bottom: 18, right: 22)
    
    quoteTextView.textContainer.maximumNumberOfLines = 4
    quoteTextView.textContainer.lineFragmentPadding = 0
    quoteTextView.textContainer.lineBreakMode = .byTruncatingTail
    quoteTextView.font = .readMeFont(size: 13)
    quoteTextView.textColor = .grey04
    quoteTextView.isEditable = false
    quoteTextView.isSelectable = false
  }
  
  private func setLayout() {
    self.addSubviews([titleLabel, contentTitleLabel,
                      impressionTextView, quoteTextView])
    
    titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalToSuperview().inset(32)
    }
    
    impressionTextView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(24)
      make.top.equalTo(titleLabel.snp.bottom).offset(20)
      make.trailing.equalToSuperview().inset(42)
      make.height.equalTo((UIScreen.main.bounds.width - 68) * 0.69)
    }
    
    contentTitleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(impressionTextView.snp.bottom).offset(28)
      make.trailing.equalToSuperview().inset(28)
    }
    
    quoteTextView.snp.makeConstraints { make in
      make.leading.equalTo(contentTitleLabel.snp.leading)
      make.top.equalTo(contentTitleLabel.snp.bottom).offset(14)
      make.trailing.equalTo(contentTitleLabel.snp.trailing)
      make.bottom.equalToSuperview()
    }
  }
}
