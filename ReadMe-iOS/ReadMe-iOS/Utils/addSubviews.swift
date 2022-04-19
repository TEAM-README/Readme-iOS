//
//  addSubviews.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/16.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
