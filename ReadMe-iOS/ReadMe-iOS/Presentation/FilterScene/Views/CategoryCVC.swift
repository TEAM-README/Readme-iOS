//
//  CategoryCVC.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/03.
//

import UIKit

import SnapKit

protocol CategoryDataSource { }

struct CategoryViewModel: CategoryDataSource {
  let category: [Category]
}

class CategoryCVC: UICollectionViewCell, UICollectionViewRegisterable {
  
  static var isFromNib: Bool = false
  var viewModel: CategoryViewModel? { didSet { bindViewModel() }}
  
  // MARK: - Vars & Lets Part
  var categoryLabel = UILabel()
  var isSelectedCell: Bool = false
  
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
    categoryLabel.text?.removeAll()
  }
}

extension CategoryCVC {
  private func configureUI() {
    self.layer.cornerRadius = 18
    self.backgroundColor = .grey15
    
    categoryLabel.font = .readMeFont(size: 16)
    categoryLabel.textColor = .grey14
  }
  
  func selectedUI() {
    self.backgroundColor = .bgBlue
    categoryLabel.textColor = .mainBlue
    isSelectedCell = true
  }
  
  func deselectedUI() {
    self.backgroundColor = .grey15
    categoryLabel.textColor = .grey14
    isSelectedCell = false
  }
  
  private func setLayout() {
    self.addSubview(categoryLabel)
    
    categoryLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  private func bindViewModel() {
    guard let viewModel = viewModel else { return }
//    categoryLabel.text = viewModel.category
    print("🤬 viewModel.category: \(viewModel.category)")
  }
}
