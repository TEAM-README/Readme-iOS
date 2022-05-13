//
//  CustomNavigationBar.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/13.
//

import UIKit

import SnapKit

final class CustomNavigationBar: UIView {
  
  // MARK: - UI Component Part
  
  private var vc: UIViewController?
  let backButton = UIButton()
  
  // MARK: - Initialize Part
  
  init(_ vc: UIViewController) {
    super.init(frame: .zero)
    self.vc = vc
    configureUI()
    setLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension CustomNavigationBar {
  
  // MARK: - UI & Layout Part
  
  private func configureUI() {
    backButton.setImage(ImageLiterals.NavigationBar.back, for: .normal)
  }
  
  private func setLayout() {
    self.addSubview(backButton)
    
    self.snp.makeConstraints { make in
      make.height.equalTo(54)
    }
    
    backButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(20)
      make.centerY.equalToSuperview()
    }
  }
  
  // MARK: - Custom Method
  
  private func popToPreviousVC() {
    self.vc?.navigationController?.popViewController(animated: true)
  }
  
  @discardableResult
  func setDefaultBackButtonAction() -> Self {
    // 기본적으로는 pop 하는 액션
    // 그 외에는 추가할 수 있도록
    backButton.press {
      self.popToPreviousVC()
    }
    return self
  }
}
