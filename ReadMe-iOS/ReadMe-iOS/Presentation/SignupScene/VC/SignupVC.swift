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
  private let maxNicknameLength = 7
  private var editEventFinished = PublishSubject<String?>()
  private var completeButtonClicked = PublishSubject<SignupDTO>()
  var viewModel: SignupViewModel!
  var loginData: LoginHistoryData!

  // MARK: - UI Component Part
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var nicknameTextField: UITextField!
  @IBOutlet weak var stateLabel: UILabel!
  @IBOutlet weak var textCountLabel: UILabel!
  @IBOutlet weak var completeButton: BottomButton!
  
  @IBOutlet weak var duplicateCheckLabel: UILabel!
  @IBOutlet weak var duplicateCheckButton: UIButton!
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
      duplicateCheckClicked: editEventFinished,
      completeButtonClicked: completeButtonClicked
      )
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    
    output.nicknameInvalid.asSignal()
      .emit(onNext: { [weak self] invalidType in
        guard let self = self else { return }
        self.completeButton.isEnabled = false
        self.duplicateCheckButton.isEnabled = false
        self.duplicateCheckLabel.textColor = UIColor.grey01
        self.setNicknameInvalidState(errorType: invalidType)
      })
      .disposed(by: self.disposeBag)
    
    output.nicknameValid.asSignal()
      .emit(onNext: { [weak self]  in
        guard let self = self else { return }
        self.duplicateCheckButton.isEnabled = true
        self.setNicknameValidState()
        self.stateLabel.text?.removeAll()
        self.completeButton.isEnabled = false
      })
      .disposed(by: self.disposeBag)
    
    output.countingLabelText.asSignal()
      .emit(onNext: { [weak self] count in
        guard let self = self else { return }
        self.textCountLabel.text = count
      })
      .disposed(by: self.disposeBag)
    
    output.nicknameDuplicatedCheckButtonState
      .subscribe(onNext: { [weak self] state in
        guard let self = self else { return }
        self.duplicateCheckLabel.textColor = state ? UIColor.grey01 : UIColor.mainBlue
        self.duplicateCheckButton.isEnabled = state
      }).disposed(by: self.disposeBag)
    
    output.signupComplete
      .subscribe(onNext: { [weak self] state in
        guard let self = self else { return }
        if state {
          self.goToBaseVC()
        } else {
          self.makeAlert(message: "네트워크 상태를 확인해주세요.")
        }
      }).disposed(by: self.disposeBag)
    
    output.nicknameNotDuplicated
      .subscribe(onNext: { [weak self] in
        self?.duplicateCheckLabel.textColor = UIColor.grey01
        self?.duplicateCheckButton.isEnabled = false
        self?.setNicknameValidState()
        self?.completeButton.isEnabled = true

        
      }).disposed(by: self.disposeBag)
  }
  
  private func configureButtonAction() {
    completeButton.rx.tap
      .bind{
        self.makeVibrate()
        let signupData = SignupDTO(nickname: self.nicknameTextField.text!,
                                   platform: self.loginData.platform,
                                   accessToken: self.loginData.accesToken)
        self.completeButtonClicked.onNext(signupData)
      }.disposed(by: self.disposeBag)
    
    duplicateCheckButton.press {
      self.makeVibrate()
      self.editEventFinished.onNext(self.nicknameTextField.text)
    }
  }
  
  private func goToBaseVC() {
    let baseVC = ModuleFactory.shared.makeBaseVC()
    self.navigationController?.pushViewController(baseVC, animated: false)
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
    
    duplicateCheckLabel.textColor = UIColor.grey01
    duplicateCheckButton.isEnabled = false
    
  }
  
  private func setNicknameValidState() {
    nicknameTextField.layer.borderColor = UIColor.mainBlue.cgColor
    stateLabel.text = I18N.Signup.availableNickname
    stateLabel.textColor = UIColor.mainBlue
    textCountLabel.textColor = .grey02
  }
  
  private func setNicknameInvalidState(errorType: NicknameInvalidType) {
    makeVibrate(degree: .light)
    duplicateCheckLabel.shake()
    nicknameTextField.shake()
    duplicateCheckLabel.textColor = UIColor.grey01
    duplicateCheckButton.isEnabled = false
    nicknameTextField.layer.borderColor = UIColor.alertRed.cgColor
    stateLabel.textColor = UIColor.alertRed
    switch(errorType) {
      case .hasCharacter:
        stateLabel.text = I18N.Signup.characterErr
        textCountLabel.textColor = .grey02
      case .nicknameDuplicated:
        stateLabel.text = I18N.Signup.nicknameDuplicatedErr
        textCountLabel.textColor = .alertRed
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
    UIView.animate(withDuration: duration, delay: 0, options: .init(rawValue: curve)) {
      self.view.layoutIfNeeded()
    }
  }
}
