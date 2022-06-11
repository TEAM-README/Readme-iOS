//
//  NaverResponseObject.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/06/11.
//

import Foundation

// MARK: - NaverResponseObject
struct NaverResponseObject: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let data: [BookData]
}

// MARK: - Item
struct BookData: Codable {
    let title: String
    let link: String
    let image: String
    let author, price, discount, publisher: String
    let pubdate, isbn, itemDescription: String

    enum CodingKeys: String, CodingKey {
        case title, link, image, author, price, discount, publisher, pubdate, isbn
        case itemDescription = "description"
    }
}
