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
  private let reportButton = UIButton()
  
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
    if viewModel.isMyPage {
      reportButton.setTitle(I18N.Button.delete, for: .normal)
      reportButton.setTitleColor(.alertRed, for: .normal)
    } else {
      reportButton.setTitle(I18N.Button.report, for: .normal)
      reportButton.setTitleColor(.grey04, for: .normal)
    }
    reportButton.titleLabel?.font = .readMeFont(size: 16, type: .medium)
    reportButton.contentHorizontalAlignment = .left
  }
  
  private func setLayout() {
    view.addSubview(reportButton)
    
    reportButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(31)
      make.top.equalToSuperview().inset(29)
      make.height.equalTo(50)
    }
  }
  
  // MARK: - Custom Method Part
  private func bindViewModels() {
    reportButton.rx.tap
      .subscribe(onNext: {
        if self.viewModel.isMyPage {
          print("👧 delete")
        } else {
          print("👅 report")
        }
      })
      .disposed(by: disposeBag)
  }
}
