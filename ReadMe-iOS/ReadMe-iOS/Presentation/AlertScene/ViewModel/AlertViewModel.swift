//
//  AlertViewModel.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/23.
//

import RxSwift

final class AlertViewModel: ViewModelType {

  private let useCase: AlertUseCase
  private let disposeBag = DisposeBag()
  
  // MARK: - Inputs
  struct Input {
    
  }
  
  // MARK: - Outputs
  struct Output {
    
  }
  
  init(useCase: AlertUseCase) {
    self.useCase = useCase
  }
}

extension AlertViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    // input,output 상관관계 작성
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    
  }
}
