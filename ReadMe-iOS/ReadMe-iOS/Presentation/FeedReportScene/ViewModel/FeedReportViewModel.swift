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
    let reportButtonClicked: Observable<Void>
    let deleteBUttonClickd: Observable<Void>
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
    // input,output 상관관계 작성
    
    // TODO: - 수정해야됨
    input.reportButtonClicked
      .subscribe(onNext: { button in
        output.reportRequestSuccess.accept(button)
      })
      .disposed(by: self.disposeBag)
    
    input.deleteBUttonClickd
      .subscribe(onNext: { button in
        output.deleteRequestSuccess.accept(button)
      })
      .disposed(by: self.disposeBag)
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    
  }
}
