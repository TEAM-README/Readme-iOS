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
import RxDataSources

final class FilterVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  private lazy var collectionViewFlowLayout = LeftAlignedCollectionViewFlowLayout()
  private let disposeBag = DisposeBag()
  private var selectedCategory: [Category] = []
  var buttonDelegate: BottomSheetDelegate?
  var viewModel: FilterViewModel!
  
  private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<CategorySectionModel> (configureCell: { dataSource, collectionView, indexPath, item in
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCVC.className, for: indexPath) as? CategoryCVC else { return UICollectionViewCell() }
    cell.categoryLabel.text = item.rawValue
    
    if self.selectedCategory.contains(item) {
      cell.changeState(isSelected: true)
    } else {
      cell.changeState(isSelected: false)
    }
    
    return cell
  })
  
  // MARK: - UI Component Part
  
  private let resetButton = UIButton()
  private let applyButton = BottomButton()
  private lazy var categoryCV = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configUI()
    self.setLayout()
    self.setCollectionView()
    self.bindViewModels()
    self.bindCollectionView()
    self.tapButton()
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
    categoryCV.backgroundColor = .clear
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
        if let cell = self.categoryCV.cellForItem(at: indexpath) as? CategoryCVC {
          if cell.isSelectedCell {
            self.selectedCategory.append(category)
            cell.changeState(isSelected: false)
          } else {
            cell.changeState(isSelected: true)
          }
        }
      })
      .disposed(by: disposeBag)
  }
  
  private func bindViewModels() {
    let input = FilterViewModel.Input(viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { i in
    })
    
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    
    output.selectedCategory.asSignal().emit { [weak self] category in
      guard let self = self else { return }
      self.selectedCategory = category
    }
  }
  
  private func tapButton() {
    resetButton.rx.tap
      .subscribe(onNext: {
        self.makeVibrate()
        self.selectedCategory.removeAll()
        self.categoryCV.reloadData()
      })
      .disposed(by: disposeBag)
    
    applyButton.rx.tap
      .subscribe(onNext: {
        self.makeVibrate()
        // TODO: - 서버통신..
        self.buttonDelegate?.dismissButtonTapped(completion: nil)
      })
      .disposed(by: disposeBag)
  }
}

extension FilterVC: UICollectionViewDelegate {
  
}

extension FilterVC: UICollectionViewDelegateFlowLayout {
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
