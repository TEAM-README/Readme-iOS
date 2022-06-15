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

enum SearchStateType {
  case emptyBeforeSearch
  case emptyAfterSearch
  case dataAfterSearch
}

class SearchVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  private var didSearch: Bool = false
  private var recentList: [SearchBookModel] = []
  private var resultList: [SearchBookModel] = []
  private var editEventFinished = PublishSubject<String?>()
  var viewModel: SearchViewModel!
  
  // MARK: - UI Component Part
  private let naviBar = UIView()
  private let closeButton = UIButton()
  private let titleLabel = UILabel()
  private let searchTextField = UITextField()
  private let searchButton = UIButton()
  private let beforeSearchEmptyLabel = UILabel()
  private let afterSearchEmptyLabel = UILabel()
  private let collectionViewFlowLayout = UICollectionViewFlowLayout()
  private lazy var bookCV = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.configureUI()
    self.setLayout()
    self.setCollectionView()
    self.setRegister()
    self.bindViewModels()
    self.setButtonActions()
  }
}

// MARK: - UI & Layout Part

extension SearchVC {
  private func configureUI() {
    navigationController?.navigationBar.isHidden = true
    
    closeButton.setImage(ImageLiterals.NavigationBar.close, for: .normal)
    
    titleLabel.text = I18N.NavigationBar.search
    titleLabel.textColor = .black
    titleLabel.font = .readMeFont(size: 16, type: .semiBold)
    
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
    view.addSubviews([naviBar, searchTextField, bookCV,
                      beforeSearchEmptyLabel, afterSearchEmptyLabel])
    
    naviBar.addSubviews([closeButton, titleLabel])
    
    naviBar.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.height.equalTo(48)
    }
    
    closeButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(14)
      make.centerY.equalToSuperview()
    }
    
    titleLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
    searchTextField.addSubview(searchButton)
    
    searchTextField.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(22)
      make.top.equalTo(naviBar.snp.bottom).offset(15)
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
    
    beforeSearchEmptyLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(searchTextField.snp.bottom).offset(185)
    }
    
    afterSearchEmptyLabel.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
}

// MARK: - Custom Method Part
extension SearchVC {
  private func bindViewModels() {
    let input = SearchViewModel.Input(
      viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in
        // viewWillAppear 호출 후 실행
      }, textEditFinished: editEventFinished)
    
    let output = self.viewModel.transform(from: input,
                                          disposeBag: self.disposeBag)
    
    output.recentList.asSignal().emit { [weak self] content in
      guard let self = self else { return }
      self.recentList = content
      
      if self.recentList.isEmpty {
        self.setStateView(type: .emptyBeforeSearch)
      } else {
        self.bookCV.reloadData()
        self.setStateView(type: .dataAfterSearch)
      }
    }.disposed(by: disposeBag)
    
    output.searchList.asSignal().emit { [weak self] content in
      guard let self = self else { return }
      self.resultList = content
      
      if self.didSearch {
        if self.resultList.isEmpty {
          self.setStateView(type: .dataAfterSearch)
        } else {
          self.bookCV.reloadData()
          self.setStateView(type: .dataAfterSearch)
        }
      }
    }
    .disposed(by: disposeBag)
  }
  
  private func setButtonActions() {
    searchButton.rx.tap
      .bind {
        self.editEventFinished.onNext(self.searchTextField.text)
        self.makeVibrate(degree: .light)
        self.didSearch = true
      }.disposed(by: self.disposeBag)
    
    closeButton.press {
      self.dismiss(animated: true)
    }
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
  
  private func setStateView(type: SearchStateType) {
    switch type {
    case .emptyBeforeSearch:
      bookCV.isHidden = true
      beforeSearchEmptyLabel.isHidden = false
      afterSearchEmptyLabel.isHidden = true
    case .emptyAfterSearch:
      bookCV.isHidden = true
      beforeSearchEmptyLabel.isHidden = true
      afterSearchEmptyLabel.isHidden = false
    case .dataAfterSearch:
      bookCV.isHidden = false
      beforeSearchEmptyLabel.isHidden = true
      afterSearchEmptyLabel.isHidden = true
    }
  }
}

extension SearchVC: UICollectionViewDelegate {
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    self.view.endEditing(true)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    var contentList: [SearchBookModel] = []
    if didSearch {
      contentList = resultList
    } else {
      contentList = recentList
    }
    let content = contentList[indexPath.item]
    let bookInfo = WriteModel.init(bookcover: content.imgURL, bookname: content.title, category: nil, author: content.author)
    let writeVC = ModuleFactory.shared.makeWriteVC(bookInfo: bookInfo)
    
    navigationController?.pushViewController(writeVC, animated: true)
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
    var contentList: [SearchBookModel] = []
    
    if didSearch {
      contentList = resultList
    } else {
      contentList = recentList
    }
    return contentList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SearchHeaderView.className, for: indexPath) as? SearchHeaderView else { return UICollectionReusableView() }
    
    return header
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCVC.className, for: indexPath) as? SearchCVC else { return UICollectionViewCell() }
    var contentList: [SearchBookModel] = []
    
    if didSearch {
      contentList = resultList
    } else {
      contentList = recentList
    }
    
    cell.initCell(image: contentList[indexPath.item].imgURL,
                  title: contentList[indexPath.item].title,
                  author: contentList[indexPath.item].author,
                  targetStr: self.searchTextField.text ?? nil)
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
