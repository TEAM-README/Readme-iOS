//
//  WriteQuoteFlow.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/21.
//

import UIKit

import SnapKit

class WriteQuoteFlow: UIView {
  
  // MARK: - Vars & Lets Part
  private let titleLabel = UILabel()
  private let contentTitleLabel = UILabel()
  private let bookCoverImageView = UIImageView()
  private let categoryLabel = UILabel()
  private let bookTitleLabel = UILabel()
  private let bookAuthorLabel = UILabel()
  let quoteTextView = UITextView()
  
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

extension WriteQuoteFlow {
  func setData(bookInfo: WriteModel, category: Category) {
    bookCoverImageView.setImage(with: bookInfo.bookcover)
    bookTitleLabel.text = bookInfo.bookname
    categoryLabel.text = category.rawValue
    bookAuthorLabel.text = bookInfo.author
    
    bookTitleLabel.setTextWithLineHeight(text: bookTitleLabel.text, lineHeightMultiple: 1.23)
    bookAuthorLabel.setTextWithLineHeight(text: bookAuthorLabel.text, lineHeightMultiple: 0.83)
  }
}

// MARK: - UI & Layout

extension WriteQuoteFlow {
  private func configureUI() {
    titleLabel.text = I18N.Write.quoteTitle
    titleLabel.font = .readMeFont(size: 16, type: .semiBold)
    titleLabel.textColor = .black
    
    quoteTextView.text = I18N.Write.quotePlaceholder
    quoteTextView.setTextWithLineHeight(text: quoteTextView.text, lineHeightMultiple: 1.33)
    quoteTextView.font = .readMeFont(size: 15)
    quoteTextView.textColor = .grey09
    
    quoteTextView.layer.borderColor = UIColor.grey00.cgColor
    quoteTextView.layer.borderWidth = 1
    quoteTextView.layer.cornerRadius = 16
    quoteTextView.textContainerInset = UIEdgeInsets(top: 18, left: 22, bottom: 18, right: 22)
    
    contentTitleLabel.text = I18N.Write.selectedBook
    contentTitleLabel.font = .readMeFont(size: 14, type: .medium)
    contentTitleLabel.textColor = .black
    contentTitleLabel.setTextWithLineHeight(text: contentTitleLabel.text, lineHeightMultiple: 1.5)
    
    categoryLabel.font = .readMeFont(size: 12)
    categoryLabel.textColor = .mainBlue
    categoryLabel.setTextWithLineHeight(text: categoryLabel.text, lineHeightMultiple: 0.83)
    
    bookTitleLabel.font = .readMeFont(size: 13, type: .medium)
    bookTitleLabel.textColor = .grey05
    bookTitleLabel.numberOfLines = 2
    
    bookAuthorLabel.font = .readMeFont(size: 12)
    bookAuthorLabel.textColor = .grey06
  }
  
  private func setLayout() {
    self.addSubviews([titleLabel, contentTitleLabel,
                      quoteTextView, bookCoverImageView, categoryLabel,
                      bookTitleLabel, bookAuthorLabel])
    
    titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalToSuperview().inset(32)
    }
    
    quoteTextView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(24)
      make.top.equalTo(titleLabel.snp.bottom).offset(20)
      make.trailing.equalToSuperview().inset(42)
      make.height.equalTo((UIScreen.main.bounds.width - 68) * 0.61)
    }
    
    contentTitleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(quoteTextView.snp.bottom).offset(37)
    }
    
    bookCoverImageView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(contentTitleLabel.snp.bottom).offset(18)
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
