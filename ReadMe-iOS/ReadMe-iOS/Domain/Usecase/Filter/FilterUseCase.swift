//
//  FilterUseCase.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/02.
//

import RxSwift
import RxRelay

protocol FilterUseCase {
  func getSelectedCategory()
//  var selectedCategory: PublishRelay<FeedCategory> { get set }
//  var category: PublishRelay<Category> { get set }
}

final class DefaultFilterUseCase {
  
  private let repository: FilterRepository
  private let disposeBag = DisposeBag()
  
  var category = PublishRelay<Category>()
  var selectedCategory = PublishRelay<Category>()
  
  init(repository: FilterRepository) {
    self.repository = repository
  }
}

extension DefaultFilterUseCase: FilterUseCase {
  func getSelectedCategory() {
    repository.getCategory()
      .filter { $0 != nil }
      .subscribe(onNext: { [weak self] entity in
        guard let self = self else { return }
//        self.category.accept(entity)
      })
      .disposed(by: disposeBag)
  }
}
