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
  private let categoryLabel = UILabel()
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
    categoryLabel.text = ""
    bookTitleLabel.text = ""
    authorLabel.text = ""
  }
}

// MARK: - setData Part
extension SearchCVC {
  func initCell(image: String, category: String, title: String, author: String) {
    bookCoverImageView.backgroundColor = .grey04
    categoryLabel.text = category
    bookTitleLabel.text = title
    authorLabel.text = author
    
    bookTitleLabel.setTextWithLineHeight(text: title, lineHeight: 21.0)
  }
}

// MARK: - UI & Layout Part
extension SearchCVC {
  private func configureUI() {
    bookCoverImageView.contentMode = .scaleAspectFill
    
    categoryLabel.font = .readMeFont(size: 12, type: .semiBold)
    categoryLabel.textColor = .mainBlue
    
    bookTitleLabel.font = .readMeFont(size: 14, type: .semiBold)
    bookTitleLabel.textColor = .grey05
    bookTitleLabel.numberOfLines = 2
    
    authorLabel.font = UIFont.readMeFont(size: 12)
    authorLabel.textColor = .grey021
    
    bottomLineView.backgroundColor = .grey00
  }
  
  private func setLayout() {
    self.addSubviews([bookCoverImageView, categoryLabel, bookTitleLabel,
                     authorLabel, bottomLineView])
    
    bookCoverImageView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.bottom.equalToSuperview().inset(18)
      make.width.equalTo(bookCoverImageView.snp.height).multipliedBy(0.69)
    }
    
    categoryLabel.snp.makeConstraints { make in
      make.leading.equalTo(bookCoverImageView.snp.trailing).offset(24)
      make.top.equalToSuperview().inset(22)
    }
    
    bookTitleLabel.snp.makeConstraints { make in
      make.leading.equalTo(categoryLabel.snp.leading)
      make.top.equalTo(categoryLabel.snp.bottom).offset(6)
      make.trailing.equalToSuperview().inset(35)
    }
    
    authorLabel.snp.makeConstraints { make in
      make.leading.equalTo(categoryLabel.snp.leading)
      make.top.equalTo(bookTitleLabel.snp.bottom).offset(14)
    }
    
    bottomLineView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
      make.height.equalTo(1)
    }
  }
}
