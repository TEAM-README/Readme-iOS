//
//  ResponseObject.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/03.
//

import Foundation

struct ResponseObject<T> {
  let status: Int?
  let success: Bool?
  let message: String?
  let data: T?
  
  enum CodingKeys: String, CodingKey {
    case status
    case success
    case message
    case data
  }
}

extension ResponseObject: Decodable where T: Decodable  {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    status = try? container.decode(Int.self, forKey: .status)
    success = try? container.decode(Bool.self, forKey: .success)
    message = try? container.decode(String.self, forKey: .message)
    data = try? container.decode(T.self, forKey: .data)
  }
}
