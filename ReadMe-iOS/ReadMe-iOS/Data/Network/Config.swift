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
//      return "https://asia-northeast3-wesopt29-328c5.cloudfunctions.net/api/v1"
      return "http://13.125.248.16:3000/"
    }
    
    static var searchURL: String {
      return "https://openapi.naver.com/v1/search/book"
    }
  }
}
