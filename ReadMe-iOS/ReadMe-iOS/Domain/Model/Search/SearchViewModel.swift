//
//  SearchViewModel.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/14.
//

import RxSwift
import RxRelay

final class SearchViewModel: ViewModelType {
  
  private let useCase: SearchUseCase
  private let disposeBag = DisposeBag()
  
  // MARK: - Inputs
  struct Input {
    let searchText: Observable<String?>
  }
  
  // MARK: - Outputs
  struct Output {
    
  }
  
  init(useCase: SearchUseCase) {
    self.useCase = useCase
  }
}

extension SearchViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    
    // TODO: - useCase.. 연결..
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    
  }
}
