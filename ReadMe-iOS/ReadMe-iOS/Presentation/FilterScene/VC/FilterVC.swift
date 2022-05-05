//
//  FilterVC.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/02.
//

import UIKit

import SnapKit
import RxSwift
import RxRelay
import RxCocoa

final class FilterVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  private let collectionViewFlowLayout = LeftAlignedCollectionViewFlowLayout()
  private let disposeBag = DisposeBag()
  private var category = PublishSubject<[FilterModel]>()
  var viewModel: FilterViewModel!
  
  // MARK: - UI Component Part
  
  private let resetButton = UIButton()
  private let applyButton = BottomButton()
  lazy var categoryCV = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configUI()
    self.setLayout()
    self.setCollectionView()
    self.bindCells()
    self.bindViewModels()
  }
}

// MARK: - UI & Layout Part

extension FilterVC {
  private func configUI() {
    view.backgroundColor = .white
    
    resetButton.setTitle(I18N.Button.reset, for: .normal)
    resetButton.setTitleColor(.grey13, for: .normal)
    resetButton.titleLabel?.font = .readMeFont(size: 16, type: .medium)
    resetButton.setImage(ImageLiterals.Filter.reset, for: .normal)
    
    applyButton.title = I18N.Button.apply
    applyButton.isEnabled = true
  }
  
  private func setLayout() {
    view.addSubviews([resetButton, categoryCV, applyButton])
    
    resetButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(30)
      make.top.equalToSuperview().inset(44)
    }
    
    categoryCV.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      make.top.equalTo(resetButton.snp.bottom).offset(34)
      make.bottom.equalTo(applyButton.snp.top).offset(-46)
    }
    
    applyButton.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(22)
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(34)
      make.height.equalTo(applyButton.snp.width).multipliedBy(0.156)
    }
  }
}

// MARK: - Custom Method Part
extension FilterVC {
  private func setCollectionView() {
    categoryCV.delegate = self
    categoryCV.dataSource = self
    
    categoryCV.backgroundColor = .clear
    collectionViewFlowLayout.estimatedItemSize = .zero
    
    CategoryCVC.register(target: categoryCV)
  }
  
  private func bindCells() {
//    let categorys = [Category.novel, Category.essay, Category.human, Category.health, Category.social, Category.hobby, Category.history, Category.religion, Category.home, Category.language, Category.travel, Category.computer, Category.magazine, Category.comic, Category.art, Category.improve, Category.economy]
    
//    Observable.of(categorys)
//      .bind(to: categoryCV.rx.items) { (collectionView, indexpath, item) -> UICollectionViewCell in
////        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.className, for: indexpath) as? CategoryCVC else { return UICollectionViewCell() }
//
//        print("🔍")
//
//        return UICollectionViewCell()
//      }
  }
  
  private func bindViewModels() {
//    let input = FilterViewModel.Input(viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in }, category: category)
//    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
  }
}

extension FilterVC: UICollectionViewDelegate {
  
}

extension FilterVC: UICollectionViewDelegateFlowLayout {
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

extension FilterVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Category.allCases.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.className, for: indexPath) as? CategoryCVC else { return UICollectionViewCell() }
    cell.categoryLabel.text = Category.allCases[indexPath.item].rawValue
    
    return cell
  }
}
