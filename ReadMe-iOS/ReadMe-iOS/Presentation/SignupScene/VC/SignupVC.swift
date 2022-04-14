//
//  SignupVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import UIKit
import RxSwift

class SignupVC: UIViewController {
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  private let maxNicknameLength = 20
  private var editEventFinished = PublishSubject<String?>()
  var viewModel: SignupViewModel!

  // MARK: - UI Component Part
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var nicknameTextField: UITextField!
  @IBOutlet weak var stateLabel: UILabel!
  @IBOutlet weak var textCountLabel: UILabel!
  @IBOutlet weak var completeButton: BottomButton!
  
  @IBOutlet weak var completeButtonBottomConstraint: NSLayoutConstraint!
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    self.registerForKeyboardNotifications()
    self.bindViewModels()
    self.configureUI()
    self.configureButtonAction()
    self.addTapGesture()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    self.unregisterForKeyboardNotifications()
  }
}

extension SignupVC {
  
  // MARK: - Custom Method Part
  private func bindViewModels() {
    let input = SignupViewModel.Input(
      nicknameText: nicknameTextField.rx.text
        .distinctUntilChanged()
        .asObservable(),
      textEditFinished: editEventFinished)
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    
    output.nicknameInvalid.asSignal()
      .emit(onNext: { [weak self] invalidType in
        guard let self = self else { return }
        self.setNicknameInvalidState(errorType: invalidType)
      })
      .disposed(by: self.disposeBag)
    
    output.nicknameValid.asSignal()
      .emit(onNext: { [weak self]  in
        guard let self = self else { return }
        self.setNicknameValidState()
      })
      .disposed(by: self.disposeBag)
    
    output.countingLabelText.asSignal()
      .emit(onNext: { [weak self] count in
        guard let self = self else { return }
        self.textCountLabel.text = count
      })
      .disposed(by: self.disposeBag)
    
  }
  
  private func configureButtonAction() {
    completeButton.rx.tap
      .bind{
        self.editEventFinished.onNext(self.nicknameTextField.text)
      }.disposed(by: self.disposeBag)
  }
}

// MARK: - UI 처리 요소 부분

extension SignupVC {
  private func configureUI() {
    titleLabel.text = I18N.Signup.title
    titleLabel.font = UIFont.readMeFont(size: 21, type: .bold)
    titleLabel.textColor = UIColor.grey05

    subtitleLabel.text = I18N.Signup.subtitle
    subtitleLabel.font = UIFont.readMeFont(size: 15, type: .regular)
    subtitleLabel.textColor = UIColor.grey03
    
    nicknameTextField.placeholder = I18N.Signup.textfieldPlacehodler
    nicknameTextField.addLeftPadding(width: 16)
    nicknameTextField.font = UIFont.readMeFont(size: 15, type: .regular)
    nicknameTextField.layer.borderColor = UIColor.grey01.cgColor
    nicknameTextField.layer.borderWidth = 1
    nicknameTextField.layer.cornerRadius = 10
  
    stateLabel.font = UIFont.readMeFont(size: 14, type: .regular)
    stateLabel.text?.removeAll()
    
    textCountLabel.font = UIFont.readMeFont(size: 14, type: .regular)
    textCountLabel.textColor = UIColor.grey02
    textCountLabel.text = "0/\(maxNicknameLength)"
    
    completeButton.title = I18N.Component.startButton
    completeButton.isEnabled = false
    
  }
  
  private func setNicknameValidState() {
    nicknameTextField.layer.borderColor = UIColor.mainBlue.cgColor
    stateLabel.text = I18N.Signup.availableNickname
    stateLabel.textColor = UIColor.mainBlue
    textCountLabel.textColor = .grey02
    completeButton.isEnabled = true
  }
  
  private func setNicknameInvalidState(errorType: NicknameInvalidType) {
    makeVibrate(degree: .light)
    nicknameTextField.shake()
    nicknameTextField.layer.borderColor = UIColor.alertRed.cgColor
    stateLabel.textColor = UIColor.alertRed
    switch(errorType) {
      case .hasCharacter:
        stateLabel.text = I18N.Signup.characterErr
        textCountLabel.textColor = .grey02
      case .nicknameDuplicated:
        stateLabel.text = I18N.Signup.nicknameDuplicatedErr
        textCountLabel.textColor = .grey02
      case .exceedMaxCount:
        stateLabel.text = I18N.Signup.byteExceedErr
        textCountLabel.textColor = .alertRed
        cutMaxLabel()
    }
    completeButton.isEnabled = false
  }
  
  private func cutMaxLabel() {
    if let text = nicknameTextField.text {
      if text.count > maxNicknameLength{
        let maxIndex = text.index(text.startIndex, offsetBy: maxNicknameLength)
        let newString = String(text[text.startIndex..<maxIndex])
        nicknameTextField.text = newString
      }
    }
  }
}

// MARK: - Keyboard Actions

extension SignupVC {
  private func registerForKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  private func unregisterForKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc private func keyboardWillShow(_ notification: Notification) {
    let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
    if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardRectangle = keyboardFrame.cgRectValue
      let keyboardHeight = keyboardRectangle.height
      completeButtonBottomConstraint.constant = keyboardHeight
    }
    
    UIView.animate(withDuration: duration, delay: 0){
      self.view.layoutIfNeeded()
    }
  }
  
  @objc private func keyboardWillHide(_ notification: Notification) {
    let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
    let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
    completeButtonBottomConstraint.constant = 34
    editEventFinished.onNext(nicknameTextField.text)
    UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve)) {
      self.view.layoutIfNeeded()
    }
  }
}
