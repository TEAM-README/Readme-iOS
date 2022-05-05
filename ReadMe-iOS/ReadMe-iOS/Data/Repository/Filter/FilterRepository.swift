//
//  FilterRepository.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/02.
//

import RxSwift

protocol FilterRepository {
  func getCategory() -> Observable<Category?>
}

final class DefaultFilterRepository {
  
  private let networkService: FilterServiceType
  private let disposeBag = DisposeBag()

  init(service: FilterServiceType) {
    self.networkService = service
  }
}

extension DefaultFilterRepository: FilterRepository {
  func getCategory() -> Observable<Category?> {
    return .create { observer in
//      let category = Category.allCases
//      observer.onNext(category)
      return Disposables.create()
    }
  }
}
