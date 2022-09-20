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
      return "http://13.125.248.16:3000/"
#else
      return "http://13.125.248.16:3001/"
#endif
    }
    
    static var searchURL: String {
      return "https://openapi.naver.com/v1/search/book"
    }
  }
}
