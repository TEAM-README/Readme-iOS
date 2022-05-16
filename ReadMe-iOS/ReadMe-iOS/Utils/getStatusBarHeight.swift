//
//  getStatusBarHeight.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/16.
//

import UIKit

extension UIViewController {
  func getStatusBarHeight() -> CGFloat {
    var statusBarHeight: CGFloat = 0
    if #available(iOS 13.0, *) {
      let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
      statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    } else {
      statusBarHeight = UIApplication.shared.statusBarFrame.height
    }
    return statusBarHeight
  }
}
