//
//  SampleViewController.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/03.
//

import UIKit
import RxSwift

class SampleVC: UIViewController {
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  var viewModel: SampleViewModel!
  
  // MARK: - UI Component Part
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindViewModels()
  }
}

extension SampleVC {
  
  // MARK: - Custom Method Part
  private func bindViewModels() {
    let input = SampleViewModel.Input()
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
  }
}
