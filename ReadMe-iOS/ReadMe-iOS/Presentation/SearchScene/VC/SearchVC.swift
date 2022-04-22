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
  private let searchButton = UIButton()
  private let beforeSearchEmptyLabel = UILabel()
  private let afterSearchEmptyLabel = UILabel()
  private let collectionViewFlowLayout = UICollectionViewFlowLayout()

  lazy var bookCV = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
  var viewModel: SearchViewModel!
  var didSearch: Bool = false
  var dataCount = 10 // 테스트용
//  var contentList: [SearchModel] = []
  var contentList: [SearchBookModel] = []
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.configureUI()
    self.setLayout()
    self.setCollectionView()
    self.setRegister()
    self.bindViewModels()
    self.tapSearchButton()
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
    
    searchButton.setImage(ImageLiterals.Search.search, for: .normal)
    
    beforeSearchEmptyLabel.text = I18N.Search.emptyBeforeSearch
    beforeSearchEmptyLabel.font = UIFont.readMeFont(size: 15, type: .medium)
    beforeSearchEmptyLabel.textColor = UIColor.black.withAlphaComponent(0.3)
    
    afterSearchEmptyLabel.text = I18N.Search.emptyAfterSearch
    afterSearchEmptyLabel.font = UIFont.readMeFont(size: 15, type: .medium)
    afterSearchEmptyLabel.textColor = UIColor.black.withAlphaComponent(0.3)
  }
  
  private func setLayout() {
    view.addSubviews([searchTextField, bookCV])
    
    searchTextField.addSubview(searchButton)
    
    searchTextField.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(22)
      make.top.equalTo(view.safeAreaLayoutGuide).inset(15)
      make.height.equalTo(44)
    }
    
    searchButton.snp.makeConstraints { make in
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
    let input = SearchViewModel.Input(
      viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in
        // viewWillAppear 호출 후 실행
      })
    
    let output = self.viewModel.transform(from: input,
                                          disposeBag: self.disposeBag)
    
    output.contentList.asSignal().emit { [weak self] content in
      guard let self = self else { return }
      self.contentList = content
      self.bookCV.reloadData()
    }
    .disposed(by: disposeBag)
  }
  
  private func bindCollectionView() {
    // TODO: - modelAndIndexSelected
  }
  
  private func tapSearchButton() {
    searchButton.rx.tap
      .subscribe(onNext: {
        // TODO: - 서버 통신
        
//        self.setEmptyViewAfterSearch()
        self.dataCount = 2
        self.didSearch = true
        self.bookCV.reloadData()
      })
      .disposed(by: disposeBag)
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
    SearchHeaderView.register(target: bookCV, isHeader: true)
  }
  
  private func setEmptyViewBeforeSearch() {
    bookCV.isHidden = true
    afterSearchEmptyLabel.isHidden = true
    beforeSearchEmptyLabel.isHidden = false
    
    view.addSubview(beforeSearchEmptyLabel)
    
    beforeSearchEmptyLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(searchTextField.snp.bottom).offset(185)
    }
  }
  
  private func setEmptyViewAfterSearch() {
    bookCV.isHidden = true
    beforeSearchEmptyLabel.isHidden = true
    afterSearchEmptyLabel.isHidden = false
    
    view.addSubview(afterSearchEmptyLabel)
    
    afterSearchEmptyLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
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
    return contentList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchHeaderView.className, for: indexPath) as? SearchHeaderView else { return UICollectionReusableView() }
    
    return header
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCVC.className, for: indexPath) as? SearchCVC else { return UICollectionViewCell() }
    cell.initCell(image: contentList[indexPath.item].imgURL,
                  category: contentList[indexPath.item].category,
                  title: contentList[indexPath.item].title,
                  author: contentList[indexPath.item].author)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    if didSearch {
      return .zero
    } else {
      let width = UIScreen.main.bounds.width
      let height = 30.0
      
      return CGSize(width: width, height: height)
    }
  }
}

extension SearchVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
  }
}
