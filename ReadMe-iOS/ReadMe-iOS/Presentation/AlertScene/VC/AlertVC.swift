//
//  AlertVC.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/23.
//

import UIKit

import SnapKit
import RxSwift

@frozen
enum AlertType {
  case oneAction
  case twoAction
}

class AlertVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  var closure: (() -> Void)?
  
  // MARK: - UI Component Part
  private let alertView = UIView()
  private let alertImageView = UIImageView()
  private let titleLabel = UILabel()
  private let descriptionLabel = UILabel()
  private let divideLineView = UIView()
  private let leftButton = UIButton()
  private let rightButton = UIButton()
  private let bottomButton = UIButton()
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    setLayout()
    bindButton()
  }
}

// MARK: - Custom Method Part
extension AlertVC {
  /// alert의 type을 설정하고, action의 title을 지정하는 함수
  /// - type: oneAction / twoAction
  /// - action: 최소 필수로 지정해줘야 하는 액션의 타이틀
  /// - otherAction: alert의 타입이 twoAction일때만 지정해주면 되는 액션의 타이틀
  func setAlertType(_ type: AlertType, action: String, _ otherAction: String? = nil) {
    switch type {
    case .oneAction:
      [leftButton, rightButton].forEach { $0.isHidden = true }
      bottomButton.setTitle(action, for: .normal)
    case .twoAction:
      bottomButton.isHidden = true
      leftButton.setTitle(action, for: .normal)
      rightButton.setTitle(otherAction, for: .normal)
    }
  }
  
  /// alert의 title와 description을 지정하는 함수
  func setAlertTitle(title: String, description: String) {
    titleLabel.text = title
    descriptionLabel.text = description
    
    titleLabel.setTextWithLineHeight(text: title, lineHeightMultiple: 1.52)
    descriptionLabel.setTextWithLineHeight(text: description, lineHeightMultiple: 1.44)
  }
  
  private func bindButton() {
    leftButton.rx.tap
      .subscribe(onNext: {
        self.dismiss(animated: true)
      })
      .disposed(by: disposeBag)
    
    rightButton.rx.tap
      .subscribe(onNext: {
        self.dismiss(animated: true) {
          self.closure?()
        }
      })
      .disposed(by: disposeBag)
    
    bottomButton.rx.tap
      .subscribe(onNext: {
        self.closure?()
      })
      .disposed(by: disposeBag)
  }
}

// MARK: - UI Part
extension AlertVC {
  private func configureUI() {
    view.backgroundColor = .black.withAlphaComponent(0.5)
    divideLineView.backgroundColor = .grey12
    alertView.backgroundColor = .white
    alertView.layer.cornerRadius = 16
    
    alertImageView.image = ImageLiterals.ReadmeAlert.alert
    
    titleLabel.numberOfLines =  2
    titleLabel.textAlignment = .center
    descriptionLabel.textAlignment = .center
    
    titleLabel.textColor = .grey05
    descriptionLabel.textColor = .grey06
    leftButton.setTitleColor(.grey06, for: .normal)
    rightButton.setTitleColor(.mainBlue, for: .normal)
    bottomButton.setTitleColor(.grey06, for: .normal)

    titleLabel.font = .readMeFont(size: 17, type: .semiBold)
    descriptionLabel.font = .readMeFont(size: 14)
    leftButton.titleLabel?.font = .readMeFont(size: 15, type: .medium)
    rightButton.titleLabel?.font = .readMeFont(size: 15, type: .medium)
    bottomButton.titleLabel?.font = .readMeFont(size: 15, type: .medium)
    
    titleLabel.sizeToFit()
    descriptionLabel.sizeToFit()
  }
}

// MARK: - Layout Part
extension AlertVC {
  private func setLayout() {
    view.addSubview(alertView)
    
    alertView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(27)
      make.height.equalTo(alertView.snp.width).multipliedBy(0.72)
      make.centerY.equalToSuperview().offset(-26)
    }
    
    alertView.addSubviews([alertImageView, titleLabel, descriptionLabel,
                          divideLineView, leftButton, rightButton,
                           bottomButton])
    
    alertImageView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().inset(34)
      make.width.height.equalTo(24)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(alertImageView.snp.bottom).offset(19)
    }
    
    descriptionLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(titleLabel.snp.bottom).offset(10)
    }
    
    divideLineView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
//      make.top.equalToSuperview().inset(alertView.frame.height * 0.76)
//      make.top.equalTo(descriptionLabel.snp.bottom).offset(29)
      
      make.bottom.equalToSuperview().inset(57)
      make.height.equalTo(1)
    }

    leftButton.snp.makeConstraints { make in
      make.leading.bottom.equalToSuperview()
      make.top.equalTo(divideLineView.snp.bottom)
      make.trailing.equalTo(divideLineView.snp.centerX)
    }

    rightButton.snp.makeConstraints { make in
      make.trailing.bottom.equalToSuperview()
      make.top.equalTo(divideLineView.snp.bottom)
      make.leading.equalTo(divideLineView.snp.centerX)
    }

    bottomButton.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      make.top.equalTo(divideLineView.snp.bottom)
    }
  }
}
