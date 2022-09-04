//
//  SearchHeaderView.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/18.
//

import UIKit

import SnapKit

class SearchHeaderView: UICollectionReusableView, UIICollectionReusableViewRegisterable {
  
  static var isFromNib: Bool = false
  
  // MARK: - Vars & Lets Part
  private let recentLabel = UILabel()
  
  // MARK: - Life Cycle Part
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureUI()
    setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
}

// MARK: - UI & Layout Part
extension SearchHeaderView {
  private func configureUI() {
    self.backgroundColor = .white
    recentLabel.text = I18N.Search.recentRead
    recentLabel.font = UIFont.readMeFont(size: 14, type: .semiBold)
    recentLabel.textColor = UIColor.grey05
  }
  
  private func setLayout() {
    self.addSubview(recentLabel)
    
    recentLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalToSuperview()
    }
  }
}
