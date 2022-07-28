//
//  WriteCheckVC.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import UIKit

import SnapKit
import RxSwift

class WriteCheckVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  private lazy var naviBar = CustomNavigationBar(self).setDefaultBackButtonAction()
  private let titleLabel = UILabel()
  private let bgImageView = UIImageView()
  private let quoteTextView = UITextView()
  private let divideLineView = UIView()
  private let impressionTextView = UITextView()
  private let usernameLabel = UILabel()
  private let dateLabel = UILabel()
  private let bookCoverImageView = UIImageView()
  private let categoryLabel = UILabel()
  private let bookTitleLabel = UILabel()
  private let bookAuthorLabel = UILabel()
  private let registerButton = BottomButton()
  private let disposeBag = DisposeBag()
  
  private var formatter = DateFormatter()
  var viewModel: WriteCheckViewModel!
  var writeRequestFail = PublishSubject<Void>()
  var writeRequest = PublishSubject<WriteCheckModel>()
  let username: String = "혜화동 꽃가마"
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.configureUI()
    self.setLayout()
    self.bindViewModels()
    self.setPreviousData()
  }
  
  open override func didMove(toParent parent: UIViewController?) {
    navigationController?.fixInteractivePopGestureRecognizer(delegate: self)
  }
}

// MARK: - Custom Method Part

extension WriteCheckVC {
  private func bindViewModels() {
    let data = self.viewModel.data.book
    let bookData = BookModel.init(isbn: data.isbn, subIsbn: data.subIsbn, title: data.title, author: data.author, image: data.image)
    let input = WriteCheckViewModel.Input(
      registerButtonClicked: self.registerButton.rx.tap.map({ _ in
        WriteCheckModel.init(bookCategory: self.categoryLabel.text ?? "",
                               quote: self.quoteTextView.text ?? "",
                               impression: self.impressionTextView.text ?? "",
                               book: bookData)
      })
      .asObservable())
    
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    
    output.writeRequestSuccess.subscribe(onNext: {[weak self] _ in
      let writeCompleteVC = ModuleFactory.shared.makeWriteCompleteVC()
      self?.navigationController?.pushViewController(writeCompleteVC, animated: true)
    })
    .disposed(by: self.disposeBag)
    
    output.showRegisterFailError.subscribe(onNext: { _ in
      self.showNetworkErrorAlert()
      print("📌 writeRequestFailError")
    })
    
    output.showNetworkError.subscribe(onNext: { [weak self] in
      guard let self = self else { return }
      self.showNetworkErrorAlert()
    })
    .disposed(by: self.disposeBag)
  }
  
  private func setPreviousData() {
    let data = viewModel.data
    
    quoteTextView.text = data.quote
    impressionTextView.text = data.impression
    
    bookCoverImageView.setImage(with: data.book.image)
    categoryLabel.text = data.bookCategory
    bookTitleLabel.text = data.book.title
    bookAuthorLabel.text = data.book.author
  }
}

// MARK: - UI Component Part

extension WriteCheckVC {
  private func configureUI() {
    view.backgroundColor = .grey00
    
    titleLabel.text = I18N.WriteCheck.titleThrough + username +  I18N.WriteCheck.titleDay
    titleLabel.numberOfLines = 2
    titleLabel.font = .readMeFont(size: 14)
    titleLabel.textColor = .grey08
    titleLabel.setTargetAttributedText(targetString: username, fontType: .bold, color: .mainBlue, text: titleLabel.text, lineHeightMultiple: 1.33)
    titleLabel.textAlignment = .center
    
    bgImageView.image = ImageLiterals.WriteCheck.bg
    
    quoteTextView.setTextWithLineHeight(text: quoteTextView.text, lineHeightMultiple: 1.33)
    quoteTextView.font = .readMeFont(size: 13)
    quoteTextView.textColor = .grey05
    quoteTextView.textContainer.maximumNumberOfLines = 4
    quoteTextView.textContainer.lineBreakMode = .byTruncatingTail
    quoteTextView.textContainerInset = .zero
    quoteTextView.textContainer.lineFragmentPadding = 0
    quoteTextView.isEditable = false
    quoteTextView.isSelectable = false
    quoteTextView.isScrollEnabled = false
    
    divideLineView.backgroundColor = .mainBlue.withAlphaComponent(0.4)
    
    impressionTextView.setTextWithLineHeight(text: impressionTextView.text, lineHeightMultiple: 1.33)
    impressionTextView.font = .readMeFont(size: 14, type: .extraLight)
    impressionTextView.textColor = .black
    impressionTextView.textContainer.maximumNumberOfLines = 6
    impressionTextView.textContainer.lineBreakMode = .byTruncatingTail
    impressionTextView.textContainerInset = .zero
    impressionTextView.textContainer.lineFragmentPadding = 0
    impressionTextView.isEditable = false
    impressionTextView.isSelectable = false
    impressionTextView.isScrollEnabled = false
    
    usernameLabel.text = username
    usernameLabel.font = .readMeFont(size: 12)
    usernameLabel.textColor = .grey10
    usernameLabel.setTextWithLineHeight(text: username, lineHeightMultiple: 0.83)
    
    formatter.dateFormat = "yyyy/MM/dd"
    let currentDateString = formatter.string(from: Date())
    dateLabel.text = currentDateString
    dateLabel.font = .readMeFont(size: 12)
    dateLabel.textColor = .grey11
    dateLabel.setTextWithLineHeight(text: dateLabel.text, lineHeightMultiple: 0.83)
    
    categoryLabel.font = .readMeFont(size: 12)
    categoryLabel.textColor = .mainBlue
    categoryLabel.setTextWithLineHeight(text: categoryLabel.text, lineHeightMultiple: 0.83)
    
    bookTitleLabel.font = .readMeFont(size: 13, type: .medium)
    bookTitleLabel.textColor = .grey05
    bookTitleLabel.setTextWithLineHeight(text: bookTitleLabel.text, lineHeightMultiple: 1.23)
    bookTitleLabel.numberOfLines = 2
    
    bookAuthorLabel.font = .readMeFont(size: 12)
    bookAuthorLabel.textColor = .grey06
    bookAuthorLabel.setTextWithLineHeight(text: bookAuthorLabel.text, lineHeightMultiple: 0.83)
    
    registerButton.title = I18N.Button.register
    registerButton.isEnabled = true
    registerButton.press(animated: true, for: .touchUpInside) { return }
  }
}

// MARK: - Layout Part

extension WriteCheckVC {
  private func setLayout() {
    view.addSubviews([titleLabel, bgImageView, naviBar, quoteTextView,
                     divideLineView, impressionTextView, usernameLabel,
                     dateLabel, bookCoverImageView, categoryLabel,
                      bookTitleLabel, bookAuthorLabel, registerButton])
    
    naviBar.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(naviBar.snp.bottom).offset(10)
      make.centerX.equalToSuperview()
      make.height.equalTo(50)
    }
    
    bgImageView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(39)
      make.leading.trailing.bottom.equalToSuperview()
    }
    
    quoteTextView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(bgImageView.snp.top).inset(41)
      make.trailing.equalToSuperview().inset(84)
    }
    
    divideLineView.snp.makeConstraints { make in
      make.leading.equalTo(quoteTextView.snp.leading)
      make.top.equalTo(quoteTextView.snp.bottom).offset(26)
      make.trailing.equalToSuperview()
      make.height.equalTo(1)
    }
    
    impressionTextView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(divideLineView.snp.bottom).offset(21)
      make.trailing.equalToSuperview().inset(42)
    }
    
    usernameLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(impressionTextView.snp.bottom).offset(30)
    }
    
    dateLabel.snp.makeConstraints { make in
      make.centerY.equalTo(usernameLabel.snp.centerY)
      make.leading.equalTo(usernameLabel.snp.trailing).offset(6)
    }
    
    bookCoverImageView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(usernameLabel.snp.bottom).offset(33)
      make.height.equalTo(82)
      make.width.equalTo(bookCoverImageView.snp.height).multipliedBy(0.68)
    }
    
    categoryLabel.snp.makeConstraints { make in
      make.leading.equalTo(bookCoverImageView.snp.trailing).offset(22)
      make.top.equalTo(bookCoverImageView.snp.top)
    }
    
    bookTitleLabel.snp.makeConstraints { make in
      make.leading.equalTo(categoryLabel.snp.leading)
      make.top.equalTo(categoryLabel.snp.bottom).offset(6)
      make.trailing.equalToSuperview().inset(57)
    }
    
    bookAuthorLabel.snp.makeConstraints { make in
      make.leading.equalTo(categoryLabel.snp.leading)
      make.top.equalTo(bookTitleLabel.snp.bottom).offset(14)
      make.trailing.equalTo(bookTitleLabel.snp.trailing)
    }
    
    registerButton.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(22)
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(34)
      make.height.equalTo(registerButton.snp.width).multipliedBy(0.156)
    }
  }
}

extension WriteCheckVC : UIGestureRecognizerDelegate {
  public func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
    return otherGestureRecognizer is PanDirectionGestureRecognizer
  }
}
