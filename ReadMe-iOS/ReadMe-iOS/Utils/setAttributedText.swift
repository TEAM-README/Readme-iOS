//
//  setAttributedText.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/13.
//

import UIKit

extension UILabel {
  func setTargetAttributedText(targetString : String,type: ReadmeFontType,color: UIColor? = nil){
    let fontSize = self.font.pointSize
    let font = UIFont.readMeFont(size: fontSize, type: fontType)
    let fullText = self.text ?? ""
    let range = (fullText as NSString).range(of: targetString)
    let attributedString = NSMutableAttributedString(string: fullText)
    attributedString.addAttributes([.font : font, .foregroundColor : color], range: range)
    attributedString.addAttribute(.font, value: font, range: range)
    if let textColor = color {
       attributedString.addAttribute(.foregroundColor, value: textColor, range: range)
    }
    self.attributedText = attributedString
  }
}
