//
//  MyPageViewModel.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import RxSwift

final class MyPageViewModel: ViewModelType {

  private let useCase: MyPageUseCase
  private let disposeBag = DisposeBag()
  
  // MARK: - Inputs
  struct Input {
    
  }
  
  // MARK: - Outputs
  struct Output {
    
  }
  
  init(useCase: MyPageUseCase) {
    self.useCase = useCase
  }
}

extension MyPageViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    // input,output 상관관계 작성
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    
  }
}
