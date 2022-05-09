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

class WriteCategoryFlow: UIView {
  
  // MARK: - Vars & Lets Part
  private let categoryTitleLabel = UILabel()
  private let collectionViewFlowLayout = LeftAlignedCollectionViewFlowLayout()
  private let disposeBag = DisposeBag()
  
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
    
    CategoryCVC.register(target: categoryCV)
  }
  
  // FIXME: - 얘를 VC로 빼야될까
  private func bindCollectionView() {
    let items = Observable.of(Category.allCases)
    
    items.asObservable()
      .bind(to: categoryCV.rx.items(cellIdentifier: CategoryCVC.className, cellType: CategoryCVC.self)) { index, item, cell in
        cell.categoryLabel.text = Category.allCases[index].rawValue
        
        if let selectedCategory = self.selectedCategory {
          if selectedCategory != Category.allCases[index] {
            cell.changeState(isSelected: false)
          } else {
            cell.changeState(isSelected: true)
          }
        }
      }
      .disposed(by: disposeBag)
    
    categoryCV.rx
      .modelAndIndexSelected(Category.self)
      .subscribe(onNext: { category, indexpath in
        self.makeVibrate(degree: .light)
        self.selectedCategory = category
        self.categoryCV.reloadData()
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
    
    let categoryLabel = UILabel()
    categoryLabel.text = Category.allCases[indexPath.item].rawValue
    categoryLabel.sizeToFit()
    
    let cellWidth = categoryLabel.frame.width + 28
    let cellHeight = 34.0
    
    return CGSize(width: cellWidth, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 12
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 8
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
  }
}
