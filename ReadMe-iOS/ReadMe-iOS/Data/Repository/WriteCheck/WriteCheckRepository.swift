//
//  WriteCheckRepository.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import RxSwift

protocol WriteCheckRepository {
  func postWrite(bookCategory: String, quote: String, impression: String, book: BookModel) -> Observable<WriteCompleteEntity?>
}

final class DefaultWriteCheckRepository {
  
  private let networkService: WriteServiceType
  private let disposeBag = DisposeBag()

  init(service: WriteServiceType) {
    self.networkService = service
  }
}

extension DefaultWriteCheckRepository: WriteCheckRepository {
  func postWrite(bookCategory: String, quote: String, impression: String, book: BookModel) -> Observable<WriteCompleteEntity?> {
    return .create { observer in
      self.networkService.postWrite(bookCategory: bookCategory, quote: quote, impression: impression, book: book)
        .subscribe(onNext: { entity in
          guard let entity = entity else { return observer.onCompleted() }
          observer.onNext(entity)
        }, onError: { err in
          observer.onError(err)
        })
        .disposed(by: self.disposeBag)
      return Disposables.create()
    }
  }
}
