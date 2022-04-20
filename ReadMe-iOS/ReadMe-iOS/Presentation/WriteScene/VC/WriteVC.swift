//
//  WriteVC.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/19.
//

import UIKit

import SnapKit
import RxSwift

@frozen
enum FlowType {
  case firstFlow
  case secondFlow
}

class WriteVC: UIViewController {
  
  // MARK: - Vars & Lets Part
  
  private let topBgView = UIView()
  private let cheerLabel = UILabel()
  private let describeLabel = UILabel()
  private let firstView = WriteFirstFlow()
  private let secondView = WriteSecondFlow()
  private let nextButton = BottomButton()
  private let progressBar = ProgressBar()
  private let disposeBag = DisposeBag()
  
  let username: String = "혜화동 꽃가마"
  let bookname: String = "바람이분다어쩌고저쩌고뭐?" // 11글자 초과면 끝에 자르기
  var viewModel: WriteViewModel!
  var flowType: FlowType = .firstFlow
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setLayout()
    bindViewModels()
    configureUI()
    setFlow(.firstFlow)
  }
}

// MARK: - Custom Method

extension WriteVC {
  private func bindViewModels() {
    nextButton.rx.tap
      .subscribe(onNext: {
        self.setFlow(self.flowType)
      })
      .disposed(by: disposeBag)
  }
}

// MARK: - Custom Methods

extension WriteVC {
  private func setFlow(_ type: FlowType) {
    switch type {
    case .firstFlow:
      setFirstFlow()
    case .secondFlow:
      setSecondFlow()
    }
  }
  
  private func setTopLabel(_ type: FlowType) {
    switch type {
    case .firstFlow:
      cheerLabel.text = username + I18N.Write.startCheer
      cheerLabel.setTextWithLineHeight(text: cheerLabel.text, lineHeightMultiple: 1.6)
      cheerLabel.setTargetAttributedText(targetString: I18N.Write.startCheer, fontType: .regular, color: .grey08)
      
      describeLabel.text = I18N.Write.startDescribe
      describeLabel.setTextWithLineHeight(text: I18N.Write.startDescribe, lineHeightMultiple: 1.6)
      
    case .secondFlow:
      cheerLabel.text = username + I18N.Write.heartCheer
      describeLabel.text = I18N.Write.heartDescribe
      
      cheerLabel.setTextWithLineHeight(text: cheerLabel.text, lineHeightMultiple: 1.6)
      cheerLabel.setTargetAttributedText(targetString: I18N.Write.heartCheer, fontType: .regular, color: .grey08)
      
      describeLabel.setTextWithLineHeight(text: I18N.Write.heartDescribe, lineHeightMultiple: 1.6)
    }
  }
  
  private func setFirstFlow() {
    progressBar.setPercentage(ratio: 0.5)
    
    UIView.animate(withDuration: 0.2,
                   delay: 0,
                   options: .curveEaseInOut,
                   animations: {
      
      [self.secondView, self.cheerLabel, self.describeLabel].forEach { $0.alpha = 0 }
      
    }, completion: { _ in
      
      self.setTopLabel(self.flowType)
      
      UIView.animate(withDuration: 0.2,
                     delay: 0,
                     options: .curveEaseInOut,
                     animations: {
        
        [self.firstView, self.cheerLabel, self.describeLabel].forEach { $0.alpha = 1 }
        
      }, completion: { _ in
        self.flowType = .secondFlow
      })
    })
    
  }
  
  private func setSecondFlow() {
    progressBar.setPercentage(ratio: 1)
    
    // 임의 데이터
    secondView.setData(bookname: "책이름이요오오오", sentence: "‘스마트폰보다 재미있는 게 있을까' 이것만큼 어려운 주제가 없다는 것을 안다. 하지만 그래도 답하고 싶었던 이유는, 언제나 카톡 속 ㅋㅋㅋ가 아닌, 실제로 웃을 수 있는 상황을 바랐기 때문이 아닐까ㅋㅋㅋㅋㅋㅋㅋㅋㅋㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹㄹ")
    
    UIView.animate(withDuration: 0.2,
                   delay: 0,
                   options: .curveEaseInOut,
                   animations: {
      
      [self.firstView, self.cheerLabel, self.describeLabel].forEach { $0.alpha = 0 }
      
    }, completion: { _ in
      UIView.animate(withDuration: 0.2,
                     delay: 0,
                     options: .curveEaseInOut,
                     animations: {
        
        self.setTopLabel(self.flowType)
        [self.secondView, self.cheerLabel, self.describeLabel].forEach { $0.alpha = 1 }
      }, completion: { _ in
        self.flowType = .firstFlow
      })
    })
  }
}

// MARK: - UI & Layout Part

extension WriteVC {
  private func configureUI() {
    topBgView.backgroundColor = .grey00
    
    progressBar.setPercentage(ratio: 0.0)
    
    cheerLabel.font = .readMeFont(size: 14, type: .bold)
    cheerLabel.textColor = .mainBlue
    
    describeLabel.font = .readMeFont(size: 14, type: .regular)
    describeLabel.textColor = .grey08
    describeLabel.numberOfLines = 2
    describeLabel.setTextWithLineHeight(text: I18N.Write.startDescribe, lineHeightMultiple: 1.6)
    
    nextButton.title = I18N.Write.next
    nextButton.isEnabled = true
    
    [cheerLabel, describeLabel, firstView, secondView].forEach { $0.alpha = 0 }
  }
  
  private func setLayout() {
    view.addSubviews([topBgView, cheerLabel, describeLabel,
                      firstView, secondView, progressBar,
                      nextButton])
    
    cheerLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().inset(28)
      make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
    }
    
    describeLabel.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(28)
      make.top.equalTo(cheerLabel.snp.bottom).offset(16)
    }
    
    topBgView.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview()
      make.bottom.equalTo(describeLabel.snp.bottom).offset(32)
    }
    
    progressBar.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(topBgView.snp.bottom)
      make.height.equalTo(2)
    }
    
    nextButton.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(22)
      make.bottom.equalTo(view.safeAreaLayoutGuide).inset(34)
      make.height.equalTo(nextButton.snp.width).multipliedBy(0.156)
    }
    
    firstView.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      make.top.equalTo(progressBar.snp.bottom)
      make.bottom.equalTo(nextButton.snp.top)
    }
    
    secondView.snp.makeConstraints { make in
      make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
      make.top.equalTo(progressBar.snp.bottom)
      make.bottom.equalTo(nextButton.snp.top)
    }
  }
}

