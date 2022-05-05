//
//  FilterViewModel.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/02.
//

import RxSwift
import RxRelay

final class FilterViewModel: ViewModelType {

//  private var category: [Category] = []
  private let useCase: FilterUseCase
  private let disposeBag = DisposeBag()
//  let category: PublishSubject<[FilterModel]> = Category.allCases.map {"\($0)"}
  
  // MARK: - Inputs
  struct Input {
    let viewWillAppearEvent: Observable<Void>
    let category: Observable<[FilterModel]>
  }
  
  // MARK: - Outputs
  struct Output {
    var selectedCategory = PublishRelay<[FilterModel]>()
//    var category = PublishRelay<[FilterModel]>()
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
    
    input.viewWillAppearEvent.subscribe(onNext: { [weak self] in
      guard let self = self else { return }
      self.useCase.getSelectedCategory()
      
    })
    .disposed(by: disposeBag)
    
    input.category.subscribe(onNext: { [weak self] category in
      guard let self = self else { return }
//      self.category = category
    })
    .disposed(by: disposeBag)
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
//    let categoryListRelay = useCase.category
//    let selectedCatagoryListRelay = useCase.selectedCategory
  }
}
