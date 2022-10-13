//
//  Config.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/03.
//

import Foundation

struct Config
{
  enum Network {
    static var baseURL: String {
#if DEBUG
      return "http://43.200.32.8:3001/"
#else
      return "http://43.200.32.8:3001/"
#endif
    }
    
    static var searchURL: String {
      return "https://openapi.naver.com/v1/search/book"
    }
  }
}
