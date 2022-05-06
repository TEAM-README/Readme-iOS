//
//  WriteCheckUseCase.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import RxSwift
import RxRelay

protocol WriteCheckUseCase {
  func postWrite(booktitle: String, bookauthor: String, bookcategory: String, quote: String, impression: String)
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
  func postWrite(booktitle: String, bookauthor: String, bookcategory: String, quote: String, impression: String) {
    repository.postWrite(booktitle: booktitle, bookauthor: bookauthor, quote: quote, impression: impression)
      .subscribe(onNext: { [weak self] entity in
        guard let self = self else { return }
        let data = WriteCheckModel(bookCover: nil, bookTitle: booktitle, bookAuthor: bookauthor, bookCategory: bookcategory, quote: quote, impression: impression)
        self.writeData.onNext(data)
        print("✏️ useCase - data: \(data)")
      }, onError: { err in
        self.writeFail.onNext(err)
      })
      .disposed(by: self.disposeBag)
  }
}
