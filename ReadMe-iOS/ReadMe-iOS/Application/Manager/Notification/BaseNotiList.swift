//
//  BaseNotiList.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/03.
//

import Foundation

enum BaseNotiList : String{
  case copyComplete
  case showNotInstallKakaomap
  case moveHomeTab
  case moveTravelSpotTab
  case moveScrapTab
  case moveMyPlanTab
  case moveSettingView
  case moveSettingWithdrawView
  case movePlanPreview // 미리보기 뷰
  case movePlanList // 여행지 목록
  case movePlanDetail // 구매후 뷰
  
  case moveHomeToPlanList
  case moveNicknamePlanList
  
  case showNetworkError
  case showIndicator
  case hideIndicator
  
  case indicatorComplete
  
  //filter
  case filterBottomSheet
  
  //PlanDetail
  case detailFoldComplete
  case planDetailButtonClicked
  case summaryFoldStateChanged
  
  static func makeNotiName(list : BaseNotiList) -> NSNotification.Name{
    return Notification.Name(String(describing: list))
  }
  
}
