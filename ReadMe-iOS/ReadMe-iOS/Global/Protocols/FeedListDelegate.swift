//
//  FeedListDelegate.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/10.
//

import Foundation

protocol FeedListDelegate {
  func moreButtonTapped(nickname: String?, feedId: String?)
}

extension FeedListDelegate {
  func moreButtonTapped(nickname: String? = nil, feedId: String? = nil) {
    moreButtonTapped(nickname: nickname, feedId: feedId)
  }
}
