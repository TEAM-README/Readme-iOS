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
  case moveLoginVC
  case report
  case writeComplete
  case filterButtonClicked
  case writeCategorySelected
  case deleteFeed
  case deleteFeedForMyPage
  
  static func makeNotiName(list : BaseNotiList) -> NSNotification.Name{
    return Notification.Name(String(describing: list))
  }
}
