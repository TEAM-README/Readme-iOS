//
//  WriteCompleteVC.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import UIKit

import SnapKit
import RxSwift

class WriteCompleteVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  var viewModel: WriteCompleteViewModel!
  
  // MARK: - UI Component Part
  private let checkImageView = UIImageView()
  private let titleLabel = UILabel()
  private let subtitleLabel = UILabel()
  private let moveButton = BottomButton()
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureUI()
    self.setLayout()
    self.bindViewModels()
  }
}

extension WriteCompleteVC {
  
  // MARK: - Custom Method Part
  
  private func bindViewModels() {
    let input = WriteCompleteViewModel.Input()
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    
    moveButton.rx.tap
      .subscribe(onNext: {
        // TODO: - 피드로 화면 전환
        print("📍 피드로 갑니다 슝")
      })
      .disposed(by: disposeBag)
  }
}

// MARK: - UI Part

extension WriteCompleteVC {
  private func configureUI() {
    checkImageView.image = ImageLiterals.WriteComplete.check
    
    titleLabel.text = I18N.WriteComplete.title
    titleLabel.textColor = .black
    titleLabel.textAlignment = .center
    titleLabel.font = .readMeFont(size: 20, type: .semiBold)
    titleLabel.setTextWithLineHeight(text: titleLabel.text, lineHeightMultiple: 1.5)
    
    subtitleLabel.text = I18N.WriteComplete.subtitle
    subtitleLabel.textColor = .grey04
    subtitleLabel.font = .readMeFont(size: 14)
    subtitleLabel.numberOfLines = 2
    // FIXME: - 둘 중에 하나만 먹음
//    subtitleLabel.setTargetAttributedText(targetString: "피드", fontType: .semiBold, color: .grey04)
//    subtitleLabel.setTargetAttributedText(targetString: "마이페이지", fontType: .semiBold, color: .grey04)
    subtitleLabel.setTextWithLineHeight(text: subtitleLabel.text, lineHeightMultiple: 1.6)
    subtitleLabel.textAlignment = .center

    moveButton.title = I18N.WriteComplete.move
    moveButton.isEnabled = true
  }
}

// MARK: - Layout Part

extension WriteCompleteVC {
  private func setLayout() {
    view.addSubviews([checkImageView, titleLabel, subtitleLabel, moveButton])
    
    checkImageView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).inset(UIScreen.main.bounds.height * 0.32)
      make.centerX.equalToSuperview()
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(checkImageView.snp.bottom).offset(23)
      make.centerX.equalToSuperview()
    }
    
    subtitleLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(23)
      make.centerX.equalToSuperview()
    }
    
    moveButton.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(22)
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(34)
      make.height.equalTo(moveButton.snp.width).multipliedBy(0.156)
    }
  }
}
