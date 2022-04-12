//
//  makeKernValue.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import UIKit

extension UILabel {
  func setCharacterSpacing(kernValue: CGFloat = -0.5) {
        guard let labelText = text else { return }
        let attributedString: NSMutableAttributedString
        if let labelAttributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

    attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSMakeRange(0, attributedString.length))

        attributedText = attributedString
    }
}


extension UITextField {
  func setCharacterSpacing(kernValue: CGFloat = -0.5) {
        guard let labelText = text else { return }
        let attributedString: NSMutableAttributedString
        if let labelAttributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
    attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSMakeRange(0, attributedString.length))

        attributedText = attributedString
    }
}

extension UITextView {
  func setCharacterSpacing(kernValue: CGFloat = -0.5) {
        guard let labelText = text else { return }
        let attributedString: NSMutableAttributedString
        if let labelAttributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
    attributedString.addAttribute(NSAttributedString.Key.kern, value: kernValue, range: NSMakeRange(0, attributedString.length))
        attributedText = attributedString
    }
}
