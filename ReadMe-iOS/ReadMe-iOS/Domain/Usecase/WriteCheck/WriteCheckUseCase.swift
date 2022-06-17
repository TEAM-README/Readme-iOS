//
//  WriteCheckUseCase.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import RxSwift
import RxRelay

protocol WriteCheckUseCase {
  func postWrite(bookcover: String, booktitle: String, bookauthor: String, bookcategory: String, quote: String, impression: String, isbn: String, subisbn: String)
  var writeData: PublishSubject<WriteCheckModel> { get set }
  var writeFail: PublishSubject<Error> { get set }
}

final class DefaultWriteCheckUseCase {
  
  private let repository: WriteCheckRepository
  private let disposeBag = DisposeBag()
  
  var writeData = PublishSubject<WriteCheckModel>()
  var writeFail = PublishSubject<Error>()
  
  init(repository: WriteCheckRepository) {
    self.repository = repository
  }
}

extension DefaultWriteCheckUseCase: WriteCheckUseCase {
  func postWrite(bookcover: String, booktitle: String, bookauthor: String, bookcategory: String, quote: String, impression: String, isbn: String, subisbn: String) {
    repository.postWrite(bookCategory: bookcategory, booktitle: booktitle, bookauthor: bookauthor, bookCover: bookcover, quote: quote, impression: impression, isbn: isbn, subIsbn: subisbn)
      .subscribe(onNext: { [weak self] entity in
        guard let self = self else { return }
        let data = WriteCheckModel(bookCover: bookcover, bookTitle: booktitle, bookAuthor: bookauthor, bookCategory: bookcategory, quote: quote, impression: impression, isbn: isbn, subisbn: subisbn)
        self.writeData.onNext(data)
      }, onError: { err in
        self.writeFail.onNext(err)
      })
      .disposed(by: self.disposeBag)
  }
}
