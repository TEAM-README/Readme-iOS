//
//  FilterViewModel.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/02.
//

import RxSwift

final class FilterViewModel: ViewModelType {

  private let useCase: FilterUseCase
  private let disposeBag = DisposeBag()
  
  // MARK: - Inputs
  struct Input {
    
  }
  
  // MARK: - Outputs
  struct Output {
    
  }
  
  init(useCase: FilterUseCase) {
    self.useCase = useCase
  }
}

extension FilterViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    // input,output 상관관계 작성
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    
  }
}
