//
//  BaseNotiList.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/03.
//

import Foundation

enum BaseNotiList : String{
  case homeButtonClicked
  case mypageButtonClicked
  case moveFeedDetail
  case moveSettingView
  case logout
  case report
  case writeComplete
  
  static func makeNotiName(list : BaseNotiList) -> NSNotification.Name{
    return Notification.Name(String(describing: list))
  }
}
