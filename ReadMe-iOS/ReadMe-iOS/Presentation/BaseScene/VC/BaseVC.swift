//
//  BaseVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import UIKit
import RxSwift

class BaseVC: UIViewController {
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  var viewModel: BaseViewModel!
  
  // MARK: - UI Component Part
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindViewModels()
  }
}

extension BaseVC {
  
  // MARK: - Custom Method Part
  private func bindViewModels() {
    let input = SampleViewModel.Input()
  }
}
