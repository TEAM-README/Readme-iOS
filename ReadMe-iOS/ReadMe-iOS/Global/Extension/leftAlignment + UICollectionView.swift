//
//  leftAlignment + UICollectionView.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/05.
//

import UIKit

final class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let attributes = super.layoutAttributesForElements(in: rect)
    
    var leftMargin = sectionInset.left
    var maxY: CGFloat = -1.0
    attributes?.forEach { layoutAttribute in
      if layoutAttribute.frame.origin.y >= maxY {
        leftMargin = sectionInset.left
      }
      
      layoutAttribute.frame.origin.x = leftMargin + 30
      
      leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
      maxY = max(layoutAttribute.frame.maxY , maxY)
    }
    
    return attributes
  }
}
