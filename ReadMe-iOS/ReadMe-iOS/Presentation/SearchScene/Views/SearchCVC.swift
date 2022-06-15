//
//  SearchCVC.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/16.
//

import UIKit

import SnapKit

class SearchCVC: UICollectionViewCell, UICollectionViewRegisterable {
  
  static var isFromNib: Bool = false
  
  // MARK: - Vars & Lets Part
  private let bookCoverImageView = UIImageView()
  private let stackView = UIStackView()
  private let bookTitleLabel = UILabel()
  private let authorLabel = UILabel()
  private let bottomLineView = UIView()
  
  // MARK: - Life Cycle Part
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureUI()
    self.setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    bookCoverImageView.image = UIImage()
    bookTitleLabel.text?.removeAll()
    authorLabel.text?.removeAll()
  }
}

// MARK: - setData Part
extension SearchCVC {
  func initCell(image: String, title: String, author: String, targetStr: String?) {
    bookCoverImageView.setImage(with: image)
    bookTitleLabel.text = title
    authorLabel.text = author
    
    bookTitleLabel.setTextWithLineHeight(text: title, lineHeightMultiple: 1.23)
    
    if let targetStr = targetStr {
      if title.contains(targetStr) {
        makeBoldLabel(str: targetStr, label: bookTitleLabel)
      }
      
      if author.contains(targetStr) {
        makeSemiBoldLabel(str: targetStr, label: authorLabel)
      }
    }
  }
}

// MARK: - UI & Layout Part
extension SearchCVC {
  private func configureUI() {
    bookCoverImageView.backgroundColor = .grey00
    bookCoverImageView.contentMode = .scaleAspectFill
    bookCoverImageView.clipsToBounds = true
    
    bookTitleLabel.font = .readMeFont(size: 14, type: .medium)
    bookTitleLabel.textColor = .grey05
    bookTitleLabel.numberOfLines = 2
    
    authorLabel.font = UIFont.readMeFont(size: 12, type: .regular)
    authorLabel.textColor = .grey06
    
    bottomLineView.backgroundColor = .grey00
    
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.spacing = 14
    stackView.addArrangedSubview(bookTitleLabel)
    stackView.addArrangedSubview(authorLabel)
  }
  
  private func makeBoldLabel(str: String, label: UILabel) {
    label.setTargetAttributedText(targetString: str, fontType: .bold, text: label.text, lineHeightMultiple: 1.23)
  }
  
  private func makeSemiBoldLabel(str: String, label: UILabel) {
    label.setTargetAttributedText(targetString: str, fontType: .semiBold, text: label.text, lineHeightMultiple: 1.23)
  }
  
  private func setLayout() {
    self.addSubviews([bookCoverImageView, stackView, bottomLineView])
    
    bookCoverImageView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.bottom.equalToSuperview().inset(18)
      make.width.equalTo(bookCoverImageView.snp.height).multipliedBy(0.69)
    }
    
    stackView.snp.makeConstraints { make in
      make.leading.equalTo(bookCoverImageView.snp.trailing).offset(24)
      make.trailing.equalToSuperview().inset(35)
      make.centerY.equalTo(bookCoverImageView.snp.centerY)
    }
    
    bottomLineView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
      make.height.equalTo(1)
    }
  }
}
