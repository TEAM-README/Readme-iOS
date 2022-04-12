//
//  MyPageVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import UIKit
import RxSwift

class MyPageVC: UIViewController {
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  var viewModel: MyPageViewModel!
  
  // MARK: - UI Component Part
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    print("MyPageVC")
    self.bindViewModels()
  }
}

extension MyPageVC {
  
  // MARK: - Custom Method Part
  private func bindViewModels() {
//    let input = MyPageViewModel.Input()
//    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
  }
}
