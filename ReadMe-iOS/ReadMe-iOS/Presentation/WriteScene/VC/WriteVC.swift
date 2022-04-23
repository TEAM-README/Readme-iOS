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
  case next
}

class WriteVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  private let topBgView = UIView()
  private let cheerLabel = UILabel()
  private let describeLabel = UILabel()
  private let firstView = WriteFirstFlow()
  private let secondView = WriteSecondFlow()
  private let nextButton = BottomButton()
  private let progressBar = ProgressBar()
  private let disposeBag = DisposeBag()
  
  var username: String = "혜화동 꽃가마"
  var bookname: String?
  var bookImgURL: String?
  var category: String?
  var author: String?
  
  private var quote: String?
  private var impression: String?
  
  var viewModel: WriteViewModel!
  var flowType: FlowType = .firstFlow
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setLayout()
    setDelegate()
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
  func setFirstFlowData(bookcover: String, bookname: String, category: String, author: String) {
    firstView.setData(bookcover: bookcover, bookname: bookname, category: category, author: author)
    self.bookname = bookname
    self.category = category
    self.author = author
    self.bookImgURL = bookcover
  }
  
  private func bindViewModels() {
    nextButton.rx.tap
      .subscribe(onNext: {
        self.setFlow(self.flowType)
      })
      .disposed(by: disposeBag)
  }
  
  private func setDelegate() {
    firstView.firstTextView.delegate = self
    secondView.secondTextView.delegate = self
  }
  
  private func pushWriteCheckView() {
    let writeCheckVC = ModuleFactory.shared.makeWriteCheckVC()
    // TODO: - 데이터 전달
    writeCheckVC.setPreviousData(bookcover: bookImgURL ?? "", category: category ?? "", bookname: bookname ?? "", author: author ?? "", quote: quote ?? "-", impression: impression ?? "-")
    navigationController?.pushViewController(writeCheckVC, animated: true)
  }
  
  private func setFlow(_ type: FlowType) {
    switch type {
    case .firstFlow:
      setFirstFlow()
    case .secondFlow:
      setSecondFlow()
    case .next:
      pushWriteCheckView()
    }
  }
  
  private func setTopLabel(_ type: FlowType) {
    switch type {
    case .firstFlow:
      cheerLabel.text = username + I18N.Write.startCheer
      cheerLabel.setTextWithLineHeight(text: cheerLabel.text, lineHeightMultiple: 1.6)
      cheerLabel.setTargetAttributedText(targetString: I18N.Write.startCheer, fontType: .regular, color: .grey08)
      
      describeLabel.text = I18N.Write.startDescribe
      describeLabel.setTextWithLineHeight(text: I18N.Write.startDescribe, lineHeightMultiple: 1.6)
      
    case .secondFlow:
      cheerLabel.text = username + I18N.Write.heartCheer
      describeLabel.text = I18N.Write.heartDescribe
      
      cheerLabel.setTextWithLineHeight(text: cheerLabel.text, lineHeightMultiple: 1.6)
      cheerLabel.setTargetAttributedText(targetString: I18N.Write.heartCheer, fontType: .regular, color: .grey08)
      
      describeLabel.setTextWithLineHeight(text: I18N.Write.heartDescribe, lineHeightMultiple: 1.6)
    default:
      return
    }
  }
  
  private func setFirstFlow() {
    progressBar.setPercentage(ratio: 0.5)
    
    UIView.animate(withDuration: 0.4,
                   delay: 0,
                   options: .curveEaseInOut,
                   animations: {
      
      [self.secondView, self.cheerLabel, self.describeLabel].forEach { $0.alpha = 0 }
      
    }, completion: { _ in
      
      self.setTopLabel(self.flowType)
      
      UIView.animate(withDuration: 0.4,
                     delay: 0,
                     options: .curveEaseInOut,
                     animations: {
        
        [self.firstView, self.cheerLabel, self.describeLabel].forEach { $0.alpha = 1 }
        
      }, completion: { _ in
        self.flowType = .secondFlow
      })
    })
  }
  
  private func setSecondFlow() {
    progressBar.setPercentage(ratio: 1)
    
    secondView.setData(bookname: bookname ?? "", sentence: quote ?? "")
    
    UIView.animate(withDuration: 0.4,
                   delay: 0,
                   options: .curveEaseInOut,
                   animations: {
      
      [self.firstView, self.cheerLabel, self.describeLabel].forEach { $0.alpha = 0 }
      
    }, completion: { _ in
      UIView.animate(withDuration: 0.4,
                     delay: 0,
                     options: .curveEaseInOut,
                     animations: {
        
        self.setTopLabel(self.flowType)
        [self.secondView, self.cheerLabel, self.describeLabel].forEach { $0.alpha = 1 }
      }, completion: { _ in
        self.flowType = .next
      })
    })
  }
  
  private func upAnimation() {
    UIView.animate(withDuration: 0.3,
                   delay: 0,
                   options: .curveEaseOut,
                   animations: {
      let frame = CGAffineTransform(translationX: 0, y: -(UIScreen.main.bounds.height*106/844))
      [self.topBgView, self.progressBar, self.firstView, self.secondView].forEach { $0.transform = frame }
      [self.cheerLabel, self.describeLabel].forEach { $0.alpha = 0 }
    }, completion: nil)
  }
  
  private func downAnimation() {
    UIView.animate(withDuration: 0.3,
                   delay: 0,
                   options: .curveEaseOut,
                   animations: {
      let frame = CGAffineTransform(translationX: 0, y: 0)
      [self.topBgView, self.progressBar, self.firstView, self.secondView].forEach { $0.transform = frame }
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
    case firstView.firstTextView:
      if textView.text == I18N.Write.firstPlaceholder {
        textView.textColor = .black
        textView.text = ""
      }
    case secondView.secondTextView:
      if textView.text == I18N.Write.secondPlaceholder {
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
    case firstView.firstTextView:
      if textView.text == "" {
        textView.text = I18N.Write.firstPlaceholder
        textView.textColor = .grey09
      } else {
        self.quote = firstView.firstTextView.text
      }
    case secondView.secondTextView:
      if textView.text == "" {
        textView.text = I18N.Write.secondPlaceholder
        textView.textColor = .grey09
      } else {
        self.impression = secondView.secondTextView.text
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
    
    progressBar.setPercentage(ratio: 0.0)
    
    cheerLabel.font = .readMeFont(size: 14, type: .bold)
    cheerLabel.textColor = .mainBlue
    
    describeLabel.font = .readMeFont(size: 14, type: .regular)
    describeLabel.textColor = .grey08
    describeLabel.numberOfLines = 2
    describeLabel.setTextWithLineHeight(text: I18N.Write.startDescribe, lineHeightMultiple: 1.6)
    
    nextButton.title = I18N.Write.next
    nextButton.isEnabled = true
    
    [cheerLabel, describeLabel, firstView, secondView].forEach { $0.alpha = 0 }
  }
  
  private func setLayout() {
    view.addSubviews([topBgView, cheerLabel, describeLabel,
                      firstView, secondView, progressBar,
                      nextButton])
    
    cheerLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
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
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(topBgView.snp.bottom)
      make.height.equalTo(2)
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

