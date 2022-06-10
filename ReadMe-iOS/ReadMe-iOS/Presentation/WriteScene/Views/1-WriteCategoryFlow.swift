//
//  WriteCategoryFlow.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/06.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

final class WriteCategoryFlow: UIView {
  
  // MARK: - Vars & Lets Part
  private let categoryTitleLabel = UILabel()
  private let collectionViewFlowLayout = LeftAlignedCollectionViewFlowLayout()
  private let disposeBag = DisposeBag()
  
  private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<CategorySectionModel> (configureCell: { dataSource, collectionView, indexPath, item in
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.className, for: indexPath) as? CategoryCVC else { return UICollectionViewCell() }
    cell.categoryLabel.text = item.rawValue

    if item.rawValue == self.selectedCategory?.rawValue {
      cell.changeState(isSelected: true)
    } else {
      cell.changeState(isSelected: false)
    }

    return cell
  })
  
  lazy var categoryCV = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
  var selectedCategory: Category?
  
  // MARK: - Life Cycles
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureUI()
    self.setLayout()
    self.setCollectionView()
    self.bindCollectionView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Custom Methods
extension WriteCategoryFlow {
  private func configureUI() {
    categoryTitleLabel.text = I18N.Write.categoryTitle
    categoryTitleLabel.font = .readMeFont(size: 16, type: .semiBold)
    categoryTitleLabel.textColor = .black
  }
  
  private func setCollectionView() {
    categoryCV.delegate = self
    categoryCV.backgroundColor = .clear
    categoryCV.allowsMultipleSelection = true
    categoryCV.isScrollEnabled = false
    
    CategoryCVC.register(target: categoryCV)
  }
  
  private func bindCollectionView() {
    let section = [
      CategorySectionModel(items: [Category.novel, Category.essay, Category.human]),
      CategorySectionModel(items: [Category.health, Category.social, Category.hobby]),
      CategorySectionModel(items: [Category.history, Category.religion, Category.home]),
      CategorySectionModel(items: [Category.language, Category.travel, Category.computer]),
      CategorySectionModel(items: [Category.magazine, Category.comic, Category.art]),
      CategorySectionModel(items: [Category.improve, Category.economy])
    ]
    
    Observable.just(section)
      .bind(to: categoryCV.rx.items(dataSource: dataSource))
      .disposed(by: self.disposeBag)
    
    categoryCV.rx
      .modelAndIndexSelected(Category.self)
      .subscribe(onNext: { category, indexpath in
        self.makeVibrate(degree: .light)
        if self.selectedCategory != category {
          self.selectedCategory = category
          self.categoryCV.reloadData()
        }
      })
      .disposed(by: disposeBag)
  }
  
  func setSelectedCategory() -> Category {
    if let category = self.selectedCategory {
      return category
    }
    return Category.improve
  }
  
  private func setLayout() {
    self.addSubviews([categoryTitleLabel, categoryCV])
    
    categoryTitleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalToSuperview().inset(32)
    }
    
    categoryCV.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(categoryTitleLabel.snp.bottom).offset(22)
      make.bottom.equalToSuperview().inset(46)
    }
  }
}

extension WriteCategoryFlow: UICollectionViewDelegate {
  
}

extension WriteCategoryFlow: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let item = dataSource[indexPath.section].items[indexPath.row]
    let categoryLabel = UILabel()
    categoryLabel.text = item.rawValue
    categoryLabel.sizeToFit()
    
    let cellWidth = categoryLabel.frame.width + 28
    let cellHeight = 34.0
    return CGSize(width: cellWidth, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 30, bottom: 12, right: 30)
  }
}
