//
//  WriteFirstFlow.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/21.
//

import UIKit

import SnapKit

class WriteFirstFlow: UIView {
  
  // MARK: - Vars & Lets Part
  private let firstTitleLabel = UILabel()
  private let firstContentTitleLabel = UILabel()
  private let bookCoverImageView = UIImageView()
  private let categoryLabel = UILabel()
  private let bookTitleLabel = UILabel()
  private let bookAuthorLabel = UILabel()
  let firstTextView = UITextView()
  
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

// MARK: - Custom Methods Part

extension WriteFirstFlow {
  func setData(bookcover: String, bookname: String, category: String, author: String) {
    bookCoverImageView.setImage(with: bookcover)
    bookTitleLabel.text = bookname
    categoryLabel.text = category
    bookAuthorLabel.text = author
  }
}

// MARK: - UI & Layout

extension WriteFirstFlow {
  private func configureUI() {
    firstTitleLabel.text = I18N.Write.firstTitle
    firstTitleLabel.font = .readMeFont(size: 16, type: .semiBold)
    firstTitleLabel.textColor = .black
    
    firstTextView.text = I18N.Write.firstPlaceholder
    firstTextView.setTextWithLineHeight(text: firstTextView.text, lineHeightMultiple: 1.6)
    firstTextView.font = .readMeFont(size: 15)
    firstTextView.textColor = .grey09
    
    firstTextView.layer.borderColor = UIColor.grey00.cgColor
    firstTextView.layer.borderWidth = 1
    firstTextView.layer.cornerRadius = 16
    firstTextView.textContainerInset = UIEdgeInsets(top: 18, left: 22, bottom: 18, right: 22)
    
    firstContentTitleLabel.text = I18N.Write.selectedBook
    firstContentTitleLabel.font = .readMeFont(size: 14, type: .medium)
    firstContentTitleLabel.textColor = .black
    firstContentTitleLabel.setTextWithLineHeight(text: firstContentTitleLabel.text, lineHeightMultiple: 1.5)
    
    categoryLabel.font = .readMeFont(size: 12)
    categoryLabel.textColor = .mainBlue
    categoryLabel.setTextWithLineHeight(text: categoryLabel.text, lineHeightMultiple: 1.0)
    
    bookTitleLabel.font = .readMeFont(size: 13, type: .medium)
    bookTitleLabel.textColor = .grey05
    bookTitleLabel.setTextWithLineHeight(text: bookTitleLabel.text, lineHeightMultiple: 1.48)
    bookTitleLabel.numberOfLines = 2
    
    bookAuthorLabel.font = .readMeFont(size: 12)
    bookAuthorLabel.textColor = .grey06
    bookAuthorLabel.setTextWithLineHeight(text: bookAuthorLabel.text, lineHeightMultiple: 1.0)
  }
  
  private func setLayout() {
    self.addSubviews([firstTitleLabel, firstContentTitleLabel,
                      firstTextView, bookCoverImageView, categoryLabel,
                      bookTitleLabel, bookAuthorLabel])
    
    firstTitleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalToSuperview().inset(32)
    }
    
    firstTextView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(24)
      make.top.equalTo(firstTitleLabel.snp.bottom).offset(20)
      make.trailing.equalToSuperview().inset(42)
      make.height.equalTo((UIScreen.main.bounds.width - 68) * 0.61)
    }
    
    firstContentTitleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(firstTextView.snp.bottom).offset(37)
    }
    
    bookCoverImageView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(firstContentTitleLabel.snp.bottom).offset(18)
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
  }
}
