//
//  WriteViewModel.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/19.
//

import RxSwift
import RxRelay

final class WriteViewModel: ViewModelType {
  
  private let useCase: WriteUseCase
  private let disposeBag = DisposeBag()
  
  // MARK: - Inputs
  struct Input {
    
  }
  
  // MARK: - Outputs
  struct Output {
    
  }
  
  init(useCase: WriteUseCase) {
    self.useCase = useCase
  }
}

extension WriteViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    
    return output
  }
}
