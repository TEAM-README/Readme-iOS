//
//  FeedListCategoryTVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/19.
//

import UIKit

struct FeedCategoryViewModel: FeedListDataSource{
  let category : [FeedCategory]
}

final class FeedListCategoryTVC: UITableViewCell, UITableViewRegisterable {
  static var isFromNib: Bool = true
  var viewModel: FeedCategoryViewModel? { didSet { bindViewModel() }}
  
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureUI()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}

extension FeedListCategoryTVC {
  private func configureUI() {
    categoryLabel.font = .readMeFont(size: 16, type: .light)
    categoryLabel.textColor = .black
    
    descriptionLabel.font = .readMeFont(size: 16, type: .light)
    categoryLabel.textColor = .black
  }
  
  private func bindViewModel() {
    guard let viewModel = viewModel else { return }
    if viewModel.category.isEmpty {
      categoryLabel.text = I18N.FeedList.categoryNoSelect
      categoryLabel.setTargetAttributedText(targetString: I18N.FeedList.categoryNoSelectBold,
                                            type: .semiBold)
      descriptionLabel.text = I18N.FeedList.categoryDescriptionNoselect
    }else {
      let boldPartString = makeCategoryBoldString(category: viewModel.category)
      
      categoryLabel.text = boldPartString + "에"
      categoryLabel.setTargetAttributedText(targetString: boldPartString,
                                            type: .semiBold)
      descriptionLabel.text = I18N.FeedList.categoryDescription
    }
  }
  
  private func makeCategoryBoldString(category: [FeedCategory]) -> String {
    var targetString: String = ""
    for (index,item) in category.enumerated() {
      if index > 0 { targetString = ", " + targetString }
      targetString += item.rawValue
    }
    if category.count > 2 {
      targetString += "외 \(category.count-2)개"
    }
    return targetString
  }
}
