//
//  FilterVC.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/02.
//

import UIKit
import RxSwift

class FilterVC: UIViewController {
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  var viewModel: FilterViewModel!
  
  // MARK: - UI Component Part
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configUI()
    self.bindViewModels()
  }
}

// MARK: - UI
extension FilterVC {
  private func configUI() {
    view.backgroundColor = .black.withAlphaComponent(0.6)
  }
}

// MARK: - Custom Method Part
extension FilterVC {
  private func bindViewModels() {
    let input = FilterViewModel.Input()
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
  }
}
