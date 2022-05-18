//
//  FeedReportViewModel.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/09.
//

import RxSwift
import RxRelay

final class FeedReportViewModel: ViewModelType {

  private let useCase: FeedReportUseCase
  private let disposeBag = DisposeBag()
  let isMyPage: Bool
  
  // MARK: - Inputs
  struct Input {
    let actionButtonClicked: Observable<Void>
  }
  
  // MARK: - Outputs
  struct Output {
    let reportRequestSuccess = PublishRelay<Void>()
    let deleteRequestSuccess = PublishRelay<Void>()
  }
  
  init(useCase: FeedReportUseCase, isMyPage: Bool) {
    self.useCase = useCase
    self.isMyPage = isMyPage
  }
}

extension FeedReportViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    
    input.actionButtonClicked
      .subscribe(onNext: { button in
        if self.isMyPage {
          output.deleteRequestSuccess.accept(button)
        } else {
          output.reportRequestSuccess.accept(button)
        }
      })
      .disposed(by: self.disposeBag)
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    
  }
}
