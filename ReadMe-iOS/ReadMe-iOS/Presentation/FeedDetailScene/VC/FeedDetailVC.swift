//
//  FeedDetailVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/16.
//

import UIKit
import RxSwift

class FeedDetailVC: UIViewController {
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  var viewModel: FeedDetailViewModel!
  
  // MARK: - UI Component Part
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindViewModels()
  }
}

extension FeedDetailVC {
  
  // MARK: - Custom Method Part
  private func bindViewModels() {
    let input = FeedDetailViewModel.Input()
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
  }
}
