//
//  WriteCheckUseCase.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import RxSwift
import RxRelay

protocol WriteCheckUseCase {
  func postWrite(category: String, quote: String, impression: String, book: BookModel)
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
  func postWrite(category: String, quote: String, impression: String, book: BookModel) {
    repository.postWrite(bookCategory: category, quote: quote, impression: impression, book: book)
      .subscribe(onNext: { [weak self] entity in
        guard let self = self else { return }
        let data = WriteCheckModel(bookCategory: category, quote: quote, impression: impression, book: book)
        self.writeData.onNext(data)
      }, onError: { err in
        self.writeFail.onNext(err)
      })
      .disposed(by: self.disposeBag)
  }
}
