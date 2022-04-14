//
//  shakeAction.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import UIKit

extension UIView {
  func shake(completion: (() -> Void)? = nil) {
      let speed = 0.75
      let time = 1.0 * speed - 0.15
      let timeFactor = CGFloat(time / 4)
      let animationDelays = [timeFactor, timeFactor * 2, timeFactor * 3]

      let shakeAnimator = UIViewPropertyAnimator(duration: time, dampingRatio: 0.3)
      shakeAnimator.addAnimations({
          self.transform = CGAffineTransform(translationX: 20, y: 0)
      })
      shakeAnimator.addAnimations({
          self.transform = CGAffineTransform(translationX: -20, y: 0)
      }, delayFactor: animationDelays[0])
      shakeAnimator.addAnimations({
          self.transform = CGAffineTransform(translationX: 20, y: 0)
      }, delayFactor: animationDelays[1])
      shakeAnimator.addAnimations({
          self.transform = CGAffineTransform(translationX: 0, y: 0)
      }, delayFactor: animationDelays[2])
      shakeAnimator.startAnimation()

      shakeAnimator.addCompletion { _ in
          completion?()
      }

      shakeAnimator.startAnimation()
  }

}
