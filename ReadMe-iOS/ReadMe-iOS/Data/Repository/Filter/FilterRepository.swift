//
//  FilterRepository.swift
//  ReadMe-iOS
//
//  Created by μμλΉ on 2022/05/02.
//

import RxSwift

protocol FilterRepository {
  func getCategory() -> Observable<FilterModel?>
}

final class DefaultFilterRepository {
  
  private let networkService: FilterServiceType
  private let disposeBag = DisposeBag()

  init(service: FilterServiceType) {
    self.networkService = service
  }
}

extension DefaultFilterRepository: FilterRepository {
  func getCategory() -> Observable<FilterModel?> {
    return makeMockFilterCategory()
  }
}

extension DefaultFilterRepository {
  private func makeMockFilterCategory() -> Observable<FilterModel?> {
    return .create { observer in
      let fakeCategory = FilterModel.init(category: [Category.economy, Category.magazine, Category.computer])
      observer.onNext(fakeCategory)
      return Disposables.create()
    }
  }
}
