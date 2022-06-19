//
//  WriteCheckViewModel.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import RxSwift
import RxRelay

final class WriteCheckViewModel: ViewModelType {

  private let useCase: WriteCheckUseCase
  private let disposeBag = DisposeBag()
  var data: WriteCheckModel
  
  // MARK: - Inputs
  struct Input {
    let registerButtonClicked: Observable<WriteCheckModel>
  }
   
  // MARK: - Outputs
  struct Output {
    var writeRequestSuccess = PublishRelay<Void>()
    var showRegisterFailError = PublishRelay<Void>()
    var showNetworkError = PublishRelay<Void>()
  }
  
  init(useCase: WriteCheckUseCase, data: WriteCheckModel) {
    self.useCase = useCase
    self.data = data
  }
}

extension WriteCheckViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    
    input.registerButtonClicked
      .subscribe(onNext: { [weak self] result in
        guard let self = self else { return }
        self.useCase.postWrite(bookcover: result.bookCover,
                               booktitle: result.bookTitle,
                               bookauthor: result.bookAuthor,
                               bookcategory: result.bookCategory,
                               quote: result.quote,
                               impression: result.impression,
                               isbn: result.isbn,
                               subisbn: result.subisbn)
      })
      .disposed(by: self.disposeBag)
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    let writeRelay = useCase.writeData
    let writeError = useCase.writeFail
    
    writeRelay.subscribe(onNext: { _ in
      output.writeRequestSuccess.accept(())
    })
    .disposed(by: self.disposeBag)
    
    writeError.subscribe(onNext: { _ in
      output.showNetworkError.accept(())
    })
    .disposed(by: self.disposeBag)
  }
}
