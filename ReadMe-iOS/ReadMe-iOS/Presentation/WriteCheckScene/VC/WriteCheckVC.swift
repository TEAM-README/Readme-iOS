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
  var viewModel: WriteCheckViewModel!
  let username: String = "수빈랏소짱"
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.configureUI()
    self.setLayout()
    self.bindViewModels()
  }
  
  open override func didMove(toParent parent: UIViewController?) {
    navigationController?.fixInteractivePopGestureRecognizer(delegate: self)
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
    titleLabel.textAlignment = .center
    // FIXME: - 둘 중에 하나만 적용됨
    titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeightMultiple: 1.6)
    titleLabel.setTargetAttributedText(targetString: username, fontType: .bold, color: .mainBlue)
    
    bgImageView.image = ImageLiterals.WriteCheck.bg
    
    quoteTextView.text = "‘스마트폰보다 재미있는게 있을까' 이것만큼 어려운주제가 없다는 것을 안다. 하지만 그래도 답하고 싶었던 이유는, 언제나 카톡 속ㅋㅋㅋ가 아닌, 실제로 웃을 수 있는 상황을 바랐기 때문이 아닐까"
    quoteTextView.font = .readMeFont(size: 14)
    quoteTextView.textColor = .grey05
    quoteTextView.textContainer.maximumNumberOfLines = 4
    quoteTextView.textContainer.lineBreakMode = .byTruncatingTail
    quoteTextView.setTextWithLineHeight(text: quoteTextView.text, lineHeightMultiple: 1.6)
    quoteTextView.isEditable = false
    quoteTextView.isSelectable = false
    quoteTextView.isScrollEnabled = false
    
    divideLineView.backgroundColor = .mainBlue.withAlphaComponent(0.4)
    
    impressionTextView.text = "나만의 시간을 보내고 싶어서 휴학을 했어요. 하지만 밤새 유튜브 보고 새벽 5시에 잠들고 오후 3시에 일어나는게 반복돼요. 스마트폰이 제 시간을 뺏어간다는 느낌이 들어 회의감이 자주 들었어요. 그래서 저 문장이 유독 공감갔고, '스마트폰보다 재미있는게 있을까'란 질문에 생각을 해봤지만 생각이 잘 안나더라구용. 한번 찾아보려합니다."
    impressionTextView.font = .readMeFont(size: 14, type: .extraLight)
    impressionTextView.textColor = .black
    impressionTextView.textContainer.maximumNumberOfLines = 6
    impressionTextView.textContainer.lineBreakMode = .byTruncatingTail
    // FIXME: - lineheight가 위로도 붙어서 레이아웃이 제대로 맞지 않는 것 같아여
    impressionTextView.setTextWithLineHeight(text: impressionTextView.text, lineHeightMultiple: 1.6)
    impressionTextView.isEditable = false
    impressionTextView.isSelectable = false
    impressionTextView.isScrollEnabled = false
    
    usernameLabel.text = username
    usernameLabel.font = .readMeFont(size: 12)
    usernameLabel.textColor = .grey10
    usernameLabel.setTextWithLineHeight(text: username, lineHeightMultiple: 1.0)
    
    dateLabel.text = "2021/10/33"
    dateLabel.font = .readMeFont(size: 12)
    dateLabel.textColor = .grey11
    dateLabel.setTextWithLineHeight(text: dateLabel.text, lineHeightMultiple: 1.0)
    
    bookCoverImageView.backgroundColor = .alertRed
    
    categoryLabel.text = "경제/경영"
    categoryLabel.font = .readMeFont(size: 12)
    categoryLabel.textColor = .mainBlue
    categoryLabel.setTextWithLineHeight(text: categoryLabel.text, lineHeightMultiple: 1.0)
    
    bookTitleLabel.text = "운명을 바꾸는 부동산 투자 수업 운명을 바꾸는 부동산 투자 수업 ..."
    bookTitleLabel.font = .readMeFont(size: 13, type: .medium)
    bookTitleLabel.textColor = .grey05
    bookTitleLabel.setTextWithLineHeight(text: bookTitleLabel.text, lineHeightMultiple: 1.48)
    bookTitleLabel.numberOfLines = 2
    
    bookAuthorLabel.text = "부동산읽어주는남자(정태익) 저 "
    bookAuthorLabel.font = .readMeFont(size: 12)
    bookAuthorLabel.textColor = .grey06
    bookAuthorLabel.setTextWithLineHeight(text: bookAuthorLabel.text, lineHeightMultiple: 1.0)
    
    registerButton.title = I18N.WriteCheck.register
    registerButton.isEnabled = true
  }
}

// MARK: - Custom Method Part

extension WriteCheckVC {
  
  private func bindViewModels() {
    let input = WriteCheckViewModel.Input()
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
  }
}

// MARK: - Layout Part

extension WriteCheckVC {
  private func setLayout() {
    view.addSubviews([titleLabel, bgImageView, quoteTextView,
                     divideLineView, impressionTextView, usernameLabel,
                     dateLabel, bookCoverImageView, categoryLabel,
                      bookTitleLabel, bookAuthorLabel, registerButton])
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
      make.centerX.equalToSuperview()
      make.height.equalTo(41)
    }
    
    bgImageView.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(39)
      make.trailing.bottom.equalToSuperview()
    }
    
    quoteTextView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(bgImageView.snp.top).inset(26) // 41
      make.trailing.equalToSuperview().inset(84)
    }
    
    divideLineView.snp.makeConstraints { make in
      make.leading.equalTo(quoteTextView.snp.leading)
      make.top.equalTo(quoteTextView.snp.bottom).offset(20) // 26
      make.trailing.equalToSuperview()
      make.height.equalTo(1)
    }
    
    impressionTextView.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(divideLineView.snp.bottom).offset(11) // 21
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
