//
//  SignupViewModel.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import RxSwift
import RxRelay

final class SignupViewModel: ViewModelType {

  private let useCase: SignupUseCase
  private let disposeBag = DisposeBag()
  
  // MARK: - Inputs
  struct Input {
    let nicknameText: Observable<String?>
    let textEditFinished: Observable<String?>
  }
  
  // MARK: - Outputs
  struct Output {
    var nicknameInvalid = PublishRelay<nicknameInvalidType>()
    var nicknameValid = PublishRelay<Void>()
    var countingLabelText = PublishRelay<textViewModel>()
    var stateLabelText = PublishRelay<textViewModel>()
  }
  
  init(useCase: SignupUseCase) {
    self.useCase = useCase
  }
}

extension SignupViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    
    input.nicknameText
      .filter{ $0 != nil }
      .subscribe(onNext: { [weak self] nickname in
      guard let self = self else { return }
      self.useCase.checkNicknameHasCharacter(nickname: nickname!)
    }).disposed(by: self.disposeBag)
    
    input.textEditFinished
      .filter{$0 != nil}
      .filter{$0 != ""}
      .subscribe(onNext: { [weak self] nickname in
      guard let self = self else { return }
        self.useCase.checkNicknameDuplicated(nickname: nickname!)
    }).disposed(by: self.disposeBag)
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    let duplicatedStateRelay = useCase.nicknameDuplicated
    let hasCharacterRelay = useCase.nicknameHasCharacter
    
    
  }
}


struct textViewModel {
  let text: String
  let textColor: UIColor
}
