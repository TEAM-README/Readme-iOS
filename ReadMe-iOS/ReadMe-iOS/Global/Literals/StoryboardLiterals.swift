//
//  StoryboardLiterals.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/03.
//

import UIKit

enum Storyboards: String {
  case splash = "Splash"
  case login = "Login"
  case signup = "Signup"
  case base = "Base"
  case home = "Home"
  case mypage = "MyPage"
}

extension UIStoryboard{
  static func list(_ name : Storyboards) -> UIStoryboard{
    return UIStoryboard(name: name.rawValue, bundle: nil)
  }
}
