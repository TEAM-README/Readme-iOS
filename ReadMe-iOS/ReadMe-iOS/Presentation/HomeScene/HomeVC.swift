//
//  HomeVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import UIKit
import RxSwift

class HomeVC: UIViewController {
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  var viewModel: HomeViewModel!
  
  // MARK: - UI Component Part
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindViewModels()
  }
}

extension HomeVC {
  
  // MARK: - Custom Method Part
  private func bindViewModels() {
//    let input = HomeViewModel.Input()
//    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
  }
}
