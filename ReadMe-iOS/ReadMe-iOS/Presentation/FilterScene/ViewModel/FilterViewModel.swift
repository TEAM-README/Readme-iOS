//
//  FilterViewModel.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/02.
//

import RxSwift
import RxRelay

final class FilterViewModel: ViewModelType {

  private let useCase: FilterUseCase
  private let disposeBag = DisposeBag()
  private var category: [Category] = []
  
  // MARK: - Inputs
  struct Input {
    let viewWillAppearEvent: Observable<Void>
  }
  
  // MARK: - Outputs
  struct Output {
    var selectedCategory = PublishRelay<[Category]>()
  }
  
  init(useCase: FilterUseCase) {
    self.useCase = useCase
  }
}

extension FilterViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    
    input.viewWillAppearEvent.subscribe(onNext: { [weak self] in
      guard let self = self else { return }
      self.useCase.getSelectedCategory()
      
    })
    .disposed(by: disposeBag)
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    let selectedCategoryRelay = useCase.selectedCategory
    
    selectedCategoryRelay.subscribe(onNext: { model in
      output.selectedCategory.accept(model)
    })
    .disposed(by: disposeBag)
  }
}
