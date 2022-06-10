//
//  CategorySectionModel.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/16.
//

import Foundation
import RxDataSources

struct CategorySectionModel {
  var items: [Category]
  
  init(items: [Category]) {
    self.items = items
  }
}

extension CategorySectionModel: SectionModelType {
  typealias item = Category
  
  init(original: CategorySectionModel, items: [item]) {
    self = original
    self.items = items
  }
}
