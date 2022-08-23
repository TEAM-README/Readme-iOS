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
  var buttonDelegate: BottomSheetDelegate?
  var viewModel: FeedReportViewModel!
  
  // MARK: - UI Component Part
  private let actionButton = UIButton()
  
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
      actionButton.setTitle(I18N.Button.delete, for: .normal)
      actionButton.setTitleColor(.alertRed, for: .normal)
    } else {
      actionButton.setTitle(I18N.Button.report, for: .normal)
      actionButton.setTitleColor(.grey04, for: .normal)
    }
    actionButton.titleLabel?.font = .readMeFont(size: 16, type: .medium)
    actionButton.contentHorizontalAlignment = .left
  }
  
  private func setLayout() {
    view.addSubview(actionButton)
    
    actionButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(31)
      make.top.equalToSuperview().inset(29)
      make.height.equalTo(50)
    }
  }
  
  // MARK: - Custom Method Part
  private func bindViewModels() {
    let input = FeedReportViewModel.Input(actionButtonClicked: actionButton.rx.tap.asObservable())
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    
    output.reportRequestSuccess.subscribe(onNext: { [weak self] _ in
      self?.buttonDelegate?.dismissButtonTapped(completion: {
        self?.postObserverAction(.report, userInfo: ["nickname": self?.viewModel.userNickName ?? "", "feedId": self?.viewModel.feedId ?? ""])
      })
    })
    .disposed(by: self.disposeBag)
    
    output.deleteRequestSuccess.subscribe(onNext: { [weak self] _ in
      self?.buttonDelegate?.dismissButtonTapped(completion: nil)
    })
    .disposed(by: self.disposeBag)
  }
}
