//
//  FeedListCategoryTVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/19.
//

import UIKit
import RxSwift
import RxCocoa

struct FeedCategoryViewModel: FeedListDataSource{
  let category : [FeedCategory]
}

protocol FeedCategoryDelegate: AnyObject {
  func categoryButtonTapped()
}

final class FeedListCategoryTVC: UITableViewCell, UITableViewRegisterable {
  static var isFromNib: Bool = true
  weak var buttonDelegate: FeedCategoryDelegate?
  var viewModel: FeedCategoryViewModel? { didSet { bindViewModel() }}
  
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var categoryButton: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    configureUI()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
    @IBAction func tapCategoryButton(_ sender: Any) {
        self.makeVibrate()
        self.buttonDelegate?.categoryButtonTapped()
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
                                            fontType: .semiBold)
      descriptionLabel.text = I18N.FeedList.categoryDescriptionNoselect
    }else {
      let boldPartString = makeCategoryBoldString(category: viewModel.category)
      
      categoryLabel.text = boldPartString + "에"
      categoryLabel.setTargetAttributedText(targetString: boldPartString,
                                            fontType: .semiBold)
      descriptionLabel.text = I18N.FeedList.categoryDescription
    }
  }
  
  private func makeCategoryBoldString(category: [FeedCategory]) -> String {
    var targetString: String = ""
    
    for (index,item) in category.enumerated() {
      if index >= 2 { break }
      targetString += item.rawValue
      if index != category.count - 1{
        targetString += ","
      }
    }
    
    if category.count > 2 {
      targetString = String(targetString.dropLast())
      targetString += " 외 \(category.count - 2)개"
    }
    return targetString
  }
}
