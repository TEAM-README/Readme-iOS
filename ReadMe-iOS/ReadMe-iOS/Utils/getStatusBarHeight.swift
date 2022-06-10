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
    if #available(iOS 15.0, *) {
      statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 44
    } else {
      statusBarHeight = UIApplication.shared.statusBarFrame.height
    }
    return statusBarHeight
  }
}
