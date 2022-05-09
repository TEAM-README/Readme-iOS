//
//  FeedReportViewModel.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/09.
//

import RxSwift

final class FeedReportViewModel: ViewModelType {

  private let useCase: FeedReportUseCase
  private let disposeBag = DisposeBag()
  
  // MARK: - Inputs
  struct Input {
    
  }
  
  // MARK: - Outputs
  struct Output {
    
  }
  
  init(useCase: FeedReportUseCase) {
    self.useCase = useCase
  }
}

extension FeedReportViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    // input,output 상관관계 작성
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    
  }
}
