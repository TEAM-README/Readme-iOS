//
//  WriteVC.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/19.
//

import UIKit

import SnapKit
import RxSwift

@frozen
enum FlowType {
  case firstFlow
  case secondFlow
  case thirdFlow
  case next
}

class WriteVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  private lazy var naviBar = CustomNavigationBar(self)
  private let topBgView = UIView()
  private let cheerLabel = UILabel()
  private let describeLabel = UILabel()
  private let firstView = WriteCategoryFlow()
  private let secondView = WriteQuoteFlow()
  private let thirdView = WriteImpressionFlow()
  private let nextButton = BottomButton()
  private let progressBar = ProgressBar()
  private let disposeBag = DisposeBag()
  
  private var username: String = "혜화동 꽃가마"
  private var bookname: String?
  private var bookImgURL: String?
  private var category: String?
  private var author: String?
  
  private var quote: String?
  private var impression: String?
  private var backToCancel: Bool = false
  
  var viewModel: WriteViewModel!
  var flowType: FlowType = .firstFlow
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setLayout()
    setDelegate()
    setButtonActions()
    bindViewModels()
    configureUI()
    setFlow(self.flowType)
  }
  
  open override func didMove(toParent parent: UIViewController?) {
    navigationController?.fixInteractivePopGestureRecognizer(delegate: self)
  }
}

// MARK: - Custom Method

extension WriteVC {
  private func setSecondFlowData() {
    secondView.setData(bookInfo: viewModel.bookInfo, category: firstView.setSelectedCategory())
    
    self.bookname = viewModel.bookInfo.bookname
    self.category = firstView.setSelectedCategory().rawValue
    self.author = viewModel.bookInfo.author
    self.bookImgURL = viewModel.bookInfo.bookcover
  }
  
  private func bindViewModels() {
    nextButton.rx.tap
      .subscribe(onNext: {
        self.makeVibrate(degree: .light)
        switch self.flowType {
        case .firstFlow:
          self.flowType = .secondFlow
        case .secondFlow:
          if self.secondView.quoteTextView.text != I18N.Write.quotePlaceholder {
            self.flowType = .thirdFlow
          }
        case .thirdFlow:
          if self.thirdView.impressionTextView.text != I18N.Write.impressionPlaceholder {
            self.flowType = .next
          }
        case .next:
          self.flowType = .next
        }
        self.setFlow(self.flowType)
      })
      .disposed(by: disposeBag)
  }
  
  private func setButtonActions() {
    naviBar.backButton.press {
      switch self.flowType {
      case .firstFlow:
        self.presentAlertVC()
      case .secondFlow:
        self.flowType = .firstFlow
        self.setFlow(self.flowType)
      case .thirdFlow:
        self.flowType = .secondFlow
        self.setFlow(self.flowType)
      case .next:
        self.flowType = .thirdFlow
        self.setFlow(self.flowType)
      }
    }
  }
  
  private func setDelegate() {
    secondView.quoteTextView.delegate = self
    thirdView.impressionTextView.delegate = self
  }
  
  private func pushWriteCheckView() {
    let bookData = BookModel.init(isbn: viewModel.separateIsbn()[0], subIsbn: viewModel.separateIsbn().count == 1 ? " " : viewModel.separateIsbn()[1], title: bookname ?? " ", author: author ?? " ", image: bookImgURL ?? " ")
    let data = WriteCheckModel.init(bookCategory: category ?? "", quote: quote ?? "-", impression: impression ?? "-", book: bookData)
    let writeCheckVC = ModuleFactory.shared.makeWriteCheckVC(writeInfo: data)
    navigationController?.pushViewController(writeCheckVC, animated: true)
  }
  
  private func presentAlertVC() {
    let alertVC = ModuleFactory.shared.makeAlertVC()
    alertVC.modalPresentationStyle = .overFullScreen
    alertVC.modalTransitionStyle = .crossDissolve
    alertVC.setAlertTitle(title: I18N.ReadmeAlert.title, description: I18N.ReadmeAlert.description)
    alertVC.setAlertType(.twoAction, action: I18N.ReadmeAlert.cancel, I18N.ReadmeAlert.ok)
    alertVC.closure = {
      self.navigationController?.popViewController(animated: true)
    }
    
    present(alertVC, animated: true)
  }
  
  private func setFlow(_ type: FlowType) {
    switch type {
    case .firstFlow:
      setFirstFlow()
    case .secondFlow:
      setSecondFlow()
    case .thirdFlow:
      setThirdFlow()
    case .next:
      pushWriteCheckView()
    }
  }
  
  private func setTopLabel(_ type: FlowType) {
    switch type {
    case .firstFlow:
      cheerLabel.text = username + I18N.Write.startCheer
      cheerLabel.setTextWithLineHeight(text: cheerLabel.text, lineHeightMultiple: 1.33)
      cheerLabel.setTargetAttributedText(targetString: I18N.Write.startCheer, fontType: .regular, color: .grey08)
      
      describeLabel.text = I18N.Write.startDescribe
      describeLabel.setTextWithLineHeight(text: I18N.Write.startDescribe, lineHeightMultiple: 1.33)
    case .secondFlow:
      cheerLabel.text = username + I18N.Write.startCheer
      cheerLabel.setTextWithLineHeight(text: cheerLabel.text, lineHeightMultiple: 1.33)
      cheerLabel.setTargetAttributedText(targetString: I18N.Write.startCheer, fontType: .regular, color: .grey08)
      
      describeLabel.text = I18N.Write.startDescribe
      describeLabel.setTextWithLineHeight(text: I18N.Write.startDescribe, lineHeightMultiple: 1.33)
      
    case .thirdFlow:
      cheerLabel.text = username + I18N.Write.heartCheer
      describeLabel.text = I18N.Write.heartDescribe
      
      cheerLabel.setTextWithLineHeight(text: cheerLabel.text, lineHeightMultiple: 1.33)
      cheerLabel.setTargetAttributedText(targetString: I18N.Write.heartCheer, fontType: .regular, color: .grey08)
      
      describeLabel.setTextWithLineHeight(text: I18N.Write.heartDescribe, lineHeightMultiple: 1.33)
    default:
      return
    }
  }
  
  private func setFirstFlow() {
    progressBar.setPercentage(ratio: 0.3)
    
    UIView.animate(withDuration: 0.4,
                   delay: 0,
                   options: .curveEaseInOut,
                   animations: {
      
      [self.secondView, self.thirdView,
       self.cheerLabel, self.describeLabel].forEach { $0.alpha = 0 }
      
    }, completion: { _ in
      
      self.setTopLabel(self.flowType)
      
      UIView.animate(withDuration: 0.4,
                     delay: 0,
                     options: .curveEaseInOut,
                     animations: {
        
        [self.firstView, self.cheerLabel, self.describeLabel].forEach { $0.alpha = 1 }
        
      }, completion: nil)
    })
  }
  
  private func setSecondFlow() {
    progressBar.setPercentage(ratio: 0.6)
    
    setSecondFlowData()
    UIView.animate(withDuration: 0.4,
                   delay: 0,
                   options: .curveEaseInOut,
                   animations: {
      
      [self.firstView, self.thirdView,
       self.cheerLabel, self.describeLabel].forEach { $0.alpha = 0 }
      
    }, completion: { _ in
      
      self.setTopLabel(self.flowType)
      
      UIView.animate(withDuration: 0.4,
                     delay: 0,
                     options: .curveEaseInOut,
                     animations: {
        
        [self.secondView, self.cheerLabel, self.describeLabel].forEach { $0.alpha = 1 }
        
      }, completion: nil)
    })
  }
  
  private func setThirdFlow() {
    progressBar.setPercentage(ratio: 1)
    
    thirdView.setData(bookname: bookname ?? "", sentence: quote ?? "")
    
    UIView.animate(withDuration: 0.4,
                   delay: 0,
                   options: .curveEaseInOut,
                   animations: {
      
      [self.secondView, self.firstView, self.cheerLabel, self.describeLabel].forEach { $0.alpha = 0 }
      
    }, completion: { _ in
      UIView.animate(withDuration: 0.4,
                     delay: 0,
                     options: .curveEaseInOut,
                     animations: {
        
        self.setTopLabel(self.flowType)
        [self.thirdView, self.cheerLabel, self.describeLabel].forEach { $0.alpha = 1 }
      }, completion: nil)
    })
  }
  
  private func upAnimation() {
    UIView.animate(withDuration: 0.3,
                   delay: 0,
                   options: .curveEaseOut,
                   animations: {
      let frame = CGAffineTransform(translationX: 0, y: -(UIScreen.main.bounds.height*106/844))
      [self.topBgView, self.progressBar, self.secondView, self.thirdView].forEach { $0.transform = frame }
      [self.cheerLabel, self.describeLabel].forEach { $0.alpha = 0 }
    }, completion: nil)
  }
  
  private func downAnimation() {
    UIView.animate(withDuration: 0.3,
                   delay: 0,
                   options: .curveEaseOut,
                   animations: {
      let frame = CGAffineTransform(translationX: 0, y: 0)
      [self.topBgView, self.progressBar, self.secondView, self.thirdView].forEach { $0.transform = frame }
      [self.cheerLabel, self.describeLabel].forEach { $0.alpha = 1 }
    }, completion: nil)
  }
}

// MARK: - UITextViewDelegate

extension WriteVC: UITextViewDelegate {
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
  }
  
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    upAnimation()
    switch textView {
    case secondView.quoteTextView:
      if textView.text == I18N.Write.quotePlaceholder {
        textView.textColor = .black
        textView.text = ""
      }
    case thirdView.impressionTextView:
      if textView.text == I18N.Write.impressionPlaceholder {
        textView.textColor = .black
        textView.text = ""
      }
    default:
      return true
    }
    
    return true
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    downAnimation()
    switch textView {
    case secondView.quoteTextView:
      if textView.text == "" {
        textView.text = I18N.Write.quotePlaceholder
        textView.textColor = .grey09
      } else {
        self.quote = secondView.quoteTextView.text
      }
    case thirdView.impressionTextView:
      if textView.text == "" {
        textView.text = I18N.Write.impressionPlaceholder
        textView.textColor = .grey09
      } else {
        self.impression = thirdView.impressionTextView.text
      }
    default:
      return
    }
  }
}

// MARK: - UI & Layout Part

extension WriteVC {
  private func configureUI() {
    topBgView.backgroundColor = .grey00
    
    progressBar.setDefaultPercentage(ratio: 0.0)
    
    cheerLabel.font = .readMeFont(size: 14, type: .bold)
    cheerLabel.textColor = .mainBlue
    
    describeLabel.font = .readMeFont(size: 14, type: .regular)
    describeLabel.textColor = .grey08
    describeLabel.numberOfLines = 2
    describeLabel.setTextWithLineHeight(text: I18N.Write.startDescribe, lineHeightMultiple: 1.33)
    
    nextButton.title = I18N.Button.next
    nextButton.isEnabled = true
    
    [cheerLabel, describeLabel, secondView, thirdView].forEach { $0.alpha = 0 }
  }
  
  private func setLayout() {
    view.addSubviews([topBgView, naviBar, cheerLabel,
                      describeLabel, firstView, secondView,
                      thirdView, progressBar, nextButton])
    
    naviBar.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide)
    }
    
    cheerLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(naviBar.snp.bottom).offset(14)
    }
    
    describeLabel.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(28)
      make.top.equalTo(cheerLabel.snp.bottom).offset(16)
    }
    
    topBgView.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview()
      make.bottom.equalTo(describeLabel.snp.bottom).offset(32)
    }
    
    progressBar.snp.makeConstraints { make in
      make.leading.equalToSuperview()
      make.top.equalTo(topBgView.snp.bottom)
      make.height.equalTo(2)
      make.width.equalTo(UIScreen.main.bounds.width)
    }
    
    nextButton.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(22)
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(34)
      make.height.equalTo(nextButton.snp.width).multipliedBy(0.156)
    }
    
    firstView.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      make.top.equalTo(progressBar.snp.bottom)
      make.bottom.equalTo(nextButton.snp.top)
    }
    
    secondView.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      make.top.equalTo(progressBar.snp.bottom)
      make.bottom.equalTo(nextButton.snp.top)
    }
    
    thirdView.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      make.top.equalTo(progressBar.snp.bottom)
      make.bottom.equalTo(nextButton.snp.top)
    }
  }
}

extension WriteVC : UIGestureRecognizerDelegate {
  public func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
    return otherGestureRecognizer is PanDirectionGestureRecognizer
  }
}

