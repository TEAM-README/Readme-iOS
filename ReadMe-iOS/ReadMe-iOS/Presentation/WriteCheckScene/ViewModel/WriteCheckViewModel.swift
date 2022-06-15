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
  let data: WriteCheckModel
//  private var data: WriteRequestModel
  
  // MARK: - Inputs
  struct Input {
    let registerButtonClicked: Observable<WriteRequestModel>
    let registerRequestFail: Observable<Void>
    let registerRequestSuccess: Observable<WriteRequestModel>
//    let data: Observable<WriteRequestModel>
  }
   
  // MARK: - Outputs
  struct Output {
    var writeRequestStart = PublishRelay<WriteRequestModel>()
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
    // input,output 상관관계 작성
    
    input.registerButtonClicked
      .subscribe(onNext: { result in
        output.writeRequestStart.accept(result)
      })
      .disposed(by: self.disposeBag)
    
    input.registerRequestSuccess
      .subscribe(onNext: { [weak self] registerRequest in
        guard let self = self else { return }
        self.useCase.postWrite(bookcover: registerRequest.bookCover,
                               booktitle: registerRequest.bookTitle,
                               bookauthor: registerRequest.bookAuthor,
                               bookcategory: registerRequest.bookCategory,
                               quote: registerRequest.quote,
                               impression: registerRequest.impression,
                               isbn: registerRequest.isbn,
                               subisbn: registerRequest.subisbn)
      })
      .disposed(by: self.disposeBag)
    
//    input.data.subscribe(onNext: { [weak self] data in
//      guard let self = self else { return }
//      self.data = data
//    })
//    .disposed(by: self.disposeBag)
    
    input.registerRequestFail
      .subscribe(onNext: { result in
        output.showRegisterFailError.accept(result)
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
