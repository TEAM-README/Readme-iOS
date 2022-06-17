//
//  WriteCheckRepository.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import RxSwift

protocol WriteCheckRepository {
  func postWrite(bookCategory: String, booktitle: String, bookauthor: String,  bookCover: String, quote: String, impression: String, isbn: String, subIsbn: String) -> Observable<WriteCompleteEntity?>
}

final class DefaultWriteCheckRepository {
  
  private let networkService: WriteServiceType
  private let disposeBag = DisposeBag()

  init(service: WriteServiceType) {
    self.networkService = service
  }
}

extension DefaultWriteCheckRepository: WriteCheckRepository {
  func postWrite(bookCategory: String, booktitle: String, bookauthor: String,  bookCover: String, quote: String, impression: String, isbn: String, subIsbn: String) -> Observable<WriteCompleteEntity?> {
    return .create { observer in
      self.networkService.postWrite(bookCategory: bookCategory, bookTitle: booktitle, bookAuthor: bookauthor, bookCover: bookCover, quote: quote, impression: impression, isbn: isbn, subIsbn: subIsbn)
        .subscribe(onNext: { entity in
          guard let entity = entity else { return observer.onCompleted() }
          print("🦆 entity: \(entity)")
          observer.onNext(entity)
        }, onError: { err in
          observer.onError(err)
        })
        .disposed(by: self.disposeBag)
      return Disposables.create()
    }
  }
}
