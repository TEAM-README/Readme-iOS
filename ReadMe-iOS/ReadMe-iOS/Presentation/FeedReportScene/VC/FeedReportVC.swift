//
//  FeedReportVC.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/09.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa

class FeedReportVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  var viewModel: FeedReportViewModel!
  
  // MARK: - UI Component Part
  private let buttonStackView = UIStackView()
  private let reportButton = UIButton()
  private let deleteButton = UIButton()
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindViewModels()
    self.configureUI()
    self.setLayout()
  }
}

extension FeedReportVC {
  // MARK: - UI & Layout Part
  private func configureUI() {
    reportButton.setTitle(I18N.Button.report, for: .normal)
    reportButton.setTitleColor(.grey04, for: .normal)
    reportButton.titleLabel?.font = .readMeFont(size: 16, type: .medium)
    reportButton.contentHorizontalAlignment = .left
    
    deleteButton.setTitle(I18N.Button.delete, for: .normal)
    deleteButton.setTitleColor(.alertRed, for: .normal)
    deleteButton.titleLabel?.font = .readMeFont(size: 16, type: .medium)
    deleteButton.contentHorizontalAlignment = .left
    
    buttonStackView.axis = .vertical
    buttonStackView.alignment = .leading
    buttonStackView.distribution = .fill
    buttonStackView.addArrangedSubview(reportButton)
    buttonStackView.addArrangedSubview(deleteButton)
    buttonStackView.isLayoutMarginsRelativeArrangement = true
  }
  
  private func setLayout() {
    view.addSubview(buttonStackView)
    
    buttonStackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(31)
      make.top.equalToSuperview().inset(29)
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(7)
    }
    
    reportButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
    }

    deleteButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
    }
  }
  
  // MARK: - Custom Method Part
  private func bindViewModels() {
//    let input = FeedReportViewModel.Input()
//    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    
    reportButton.rx.tap
      .subscribe(onNext: {
        print("👅 report")
      })
      .disposed(by: disposeBag)
    
    deleteButton.rx.tap
      .subscribe(onNext: {
        print("👧 delete")
      })
      .disposed(by: disposeBag)
  }
}
