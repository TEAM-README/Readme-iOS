//
//  WriteVC.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/19.
//

import UIKit

import SnapKit

@frozen
enum flowType {
  case firstFlow
  case secondFlow
}

class WriteVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  private let topBgView = UIView()
  private let cheerLabel = UILabel()
  private let describeLabel = UILabel()
  private let titleLabel = UILabel()
  private let writeTextView = UITextView()
  private let nextButton = BottomButton()
  
  private let firstView = UIView()
  private let firstTitleLabel = UILabel()
  private let bookCoverImageView = UIImageView()
  private let categoryLabel = UILabel()
  private let bookTitleLabel = UILabel()
  private let bookAuthorLabel = UILabel()
  
  private let secondView = UIView()
  private let secondTitleLabel = UILabel()
  private let sentenceTextView = UITextView()
  
  lazy var progressView = UIProgressView()
  var viewModel: WriteViewModel!
  
  // MARK: - Vars & Lets Part
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }

}

// MARK: - UI & Layout Part

extension WriteVC {
  private func configureUI() {
    
  }
  
  private func setLayout() {
    
  }
}
