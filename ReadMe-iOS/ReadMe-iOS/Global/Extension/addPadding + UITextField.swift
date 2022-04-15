//
//  addPadding + UITextField.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import Foundation
import UIKit

extension UITextField {
  func addLeftPadding(width: CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = .always
  }
}
