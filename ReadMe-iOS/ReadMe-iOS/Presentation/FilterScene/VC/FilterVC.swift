//
//  FilterVC.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/02.
//

import UIKit

import SnapKit
import RxSwift

class FilterVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  private let disposeBag = DisposeBag()
  var viewModel: FilterViewModel!
  
  // MARK: - UI Component Part
  
  private let resetButton = UIButton()
  private let applyButton = BottomButton()
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configUI()
    self.setLayout()
    self.bindViewModels()
  }
}

// MARK: - UI & Layout Part

extension FilterVC {
  private func configUI() {
    view.backgroundColor = .white
    
    resetButton.setTitle(I18N.Button.reset, for: .normal)
    resetButton.setTitleColor(.grey13, for: .normal)
    resetButton.titleLabel?.font = .readMeFont(size: 16, type: .medium)
    resetButton.setImage(ImageLiterals.Filter.reset, for: .normal)
    
    applyButton.title = I18N.Button.apply
    applyButton.isEnabled = true
  }
  
  private func setLayout() {
    view.addSubviews([resetButton, applyButton])
    
    resetButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(30)
      make.top.equalToSuperview().inset(44)
    }
    
    applyButton.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(22)
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(34)
      make.height.equalTo(applyButton.snp.width).multipliedBy(0.156)
    }
  }
}

// MARK: - Custom Method Part
extension FilterVC {
  private func bindViewModels() {
    let input = FilterViewModel.Input()
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
  }
}
