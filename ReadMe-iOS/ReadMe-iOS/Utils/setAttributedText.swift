//
//  setAttributedText.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/13.
//

import UIKit

extension UILabel {
  func setTargetAttributedText(targetString : String, fontType: ReadmeFontType, color: UIColor? = nil, text: String? = nil, lineHeightMultiple: CGFloat? = nil) {
    
    let fontSize = self.font.pointSize
    let font = UIFont.readMeFont(size: fontSize, type: fontType)
    let fullText = self.text ?? ""
    let range = (fullText as NSString).range(of: targetString)
    let attributedString = NSMutableAttributedString(string: fullText)
    
    if let text = text {
      let style = NSMutableParagraphStyle()
      style.lineHeightMultiple = lineHeightMultiple ?? 0
      
      attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: (text as NSString).range(of: text))
    }
    
    attributedString.addAttribute(.font, value: font, range: range)
    
    
    if let textColor = color {
       attributedString.addAttribute(.foregroundColor, value: textColor, range: range)
    }
    
    self.attributedText = attributedString
    
  }
}
