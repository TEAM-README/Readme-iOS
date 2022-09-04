//
//  ProgressBar.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/01/11.
//

import UIKit

class ProgressBar: XibView {

  @IBOutlet var percentBarTrailingConstraint: NSLayoutConstraint!
  
  func setDefaultPercentage(ratio: CGFloat) {
    percentBarTrailingConstraint.constant = (1 - ratio) * self.frame.width
    UIView.animate(withDuration: 0) {
      self.layoutIfNeeded()
    }
  }
    
  func setPercentage(ratio: CGFloat){
    percentBarTrailingConstraint.constant = (1 - ratio) * self.frame.width
    UIView.animate(withDuration: 0.3) {
      self.layoutIfNeeded()
    }
  }
}
