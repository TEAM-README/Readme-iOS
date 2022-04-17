//
//  SearchVC.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/14.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import SnapKit

class SearchVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  // 네비바 들어올 자리
  private let searchTextField = UITextField()
  private let searchIconImageView = UIImageView()
  private let collectionViewFlowLayout = UICollectionViewFlowLayout()

  lazy var bookCV = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
  var viewModel: SearchViewModel!
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.configureUI()
    self.setLayout()
    self.setCollectionView()
    self.setRegister()
  }
}

// MARK: - UI & Layout Part

extension SearchVC {
  private func configureUI() {
    searchTextField.placeholder = I18N.Search.textfieldPlaceholder
    searchTextField.font = UIFont.readMeFont(size: 15)
    searchTextField.addLeftPadding(width: 22)
    searchTextField.addRightPadding(width: 44)
    searchTextField.backgroundColor = .grey00
    searchTextField.layer.cornerRadius = 22
    searchTextField.delegate = self
    
    searchIconImageView.image = UIImage(named: "ic_ search")
  }
  
  private func setLayout() {
    view.addSubviews([searchTextField, bookCV])
    
    searchTextField.addSubview(searchIconImageView)
    
    searchTextField.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(22)
      make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
      make.height.equalTo(44)
    }
    
    searchIconImageView.snp.makeConstraints { make in
      make.centerY.equalToSuperview()
      make.trailing.equalToSuperview().inset(16)
      make.width.height.equalTo(24)
    }
    
    bookCV.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
      make.top.equalTo(searchTextField.snp.bottom).offset(30)
    }
  }
}

// MARK: - Custom Method Part
extension SearchVC {
  private func bindViewModels() {
//    let input = SearchViewModel.Input(
//      searchText: searchTextField.rx.text
//    )
  }
  
  private func setCollectionView() {
    bookCV.delegate = self
    bookCV.dataSource = self
    
    bookCV.showsVerticalScrollIndicator = false
    bookCV.backgroundColor = .clear
    
    collectionViewFlowLayout.scrollDirection = .vertical
  }
  
  private func setRegister() {
    SearchCVC.register(target: bookCV)
//    SearchHeaderView.register(target: bookCV, isHeader: true)
    bookCV.register(SearchHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchHeaderView.className)
  }
}

extension SearchVC: UICollectionViewDelegate {
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    self.view.endEditing(true)
  }
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = width*146/390
    
    return CGSize(width: width, height: height)
  }
}

extension SearchVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchHeaderView.className, for: indexPath) as? SearchHeaderView else { return UICollectionReusableView() }
    
    return header
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCVC.className, for: indexPath) as? SearchCVC else { return UICollectionViewCell() }
    cell.initCell(image: "-", category: "자기계발", title: "운명을 바꾸는 부동산 투자 수업 운명을 바꾸는 부동산 투자 수업이지롱가리아아아아하나두울셋", author: "부동산읽어주는남자(정태익) 저")
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    let width = UIScreen.main.bounds.width
    let height = 30.0
    
    return CGSize(width: width, height: height)
  }
}

extension SearchVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
  }
}
