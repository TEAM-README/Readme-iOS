//
//  WriteCheckRepository.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import RxSwift

protocol WriteCheckRepository {
  func postWrite(booktitle: String, bookauthor: String, quote: String, impression: String) -> Observable<Bool?>
}

final class DefaultWriteCheckRepository {
  
  private let networkService: WriteServiceType
  private let disposeBag = DisposeBag()

  init(service: WriteServiceType) {
    self.networkService = service
  }
}

extension DefaultWriteCheckRepository: WriteCheckRepository {
  func postWrite(booktitle: String, bookauthor: String, quote: String, impression: String) -> Observable<Bool?> {
    return .create { observer in
      print("📌 repository")
      self.networkService.postWrite(bookTitle: booktitle, bookAuthor: bookauthor, quote: quote, impression: impression)
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
