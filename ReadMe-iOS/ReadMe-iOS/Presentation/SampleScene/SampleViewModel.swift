//
//  SampleViewModel.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/03.
//

import RxSwift

final class SampleViewModel: ViewModelType {

  private let useCase: SampleUseCase
  private let disposeBag = DisposeBag()
  
  // MARK: - Inputs
  struct Input {
    
  }
  
  // MARK: - Outputs
  struct Output {
    
  }
  
  init(useCase: SampleUseCase) {
    self.useCase = useCase
  }
}

extension SampleViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    // input,output 상관관계 작성
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    
  }
}
