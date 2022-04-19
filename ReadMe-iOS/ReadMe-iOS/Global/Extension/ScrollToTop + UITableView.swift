//
//  File.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/19.
//

import UIKit
extension UITableView {
  func scrollToTop() {
      DispatchQueue.main.async {
          let indexPath = IndexPath(row: 0, section: 0)
          if self.hasRowAtIndexPath(indexPath: indexPath) {
              self.scrollToRow(at: indexPath, at: .top, animated: false)
         }
      }
  }

  func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
      return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
  }
}

