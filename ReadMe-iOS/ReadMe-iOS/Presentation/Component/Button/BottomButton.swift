//
//  BottomButton.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import UIKit

final class BottomButton: UIButton {
  override var isEnabled: Bool { didSet{ configureUI() }}
  var title: String = "" { didSet{ configureTitle() }}
  
  private func configureUI() {
    self.backgroundColor = isEnabled ? UIColor.mainBlue : UIColor.grey01
    self.layer.cornerRadius = 12
    self.titleLabel?.font = UIFont.readMeFont(size: 15, type: .medium)
    self.titleLabel?.textColor = .white
  }
  
  private func configureTitle() {
    self.setTitle(title, for: .normal)
  }
}


