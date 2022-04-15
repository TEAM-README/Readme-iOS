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
  private let maxCount = 20
  
  // MARK: - Inputs
  struct Input {
    let nicknameText: Observable<String?>
    let textEditFinished: Observable<String?>
  }
  
  // MARK: - Outputs
  struct Output {
    var nicknameInvalid = PublishRelay<NicknameInvalidType>()
    var nicknameValid = PublishRelay<Void>()
    var countingLabelText = PublishRelay<String>()
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
      .filter{$0 != ""}
      .subscribe(onNext: { [weak self] nickname in
        guard let self = self else { return }
        self.useCase.checkNicknameExceed(nickname: nickname!)
        self.useCase.checkNicknameHasCharacter(nickname: nickname!)
        output.countingLabelText.accept("\(nickname!.count)/\(self.maxCount)")
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
    let didExceededRelay = useCase.nicknameExceeded
    
    let currentNicknameState = Observable.combineLatest(hasCharacterRelay,didExceededRelay) { hasCharacter, didExceeded -> NicknameInvalidType? in
      if didExceeded { return .exceedMaxCount }
      else if hasCharacter { return .hasCharacter }
      else { return .none }
    }
    
    duplicatedStateRelay.subscribe(onNext: { hasError in
      if hasError {
        output.nicknameInvalid.accept(.nicknameDuplicated)
        print("duplicatedStateRelay")

      }else {
        print("duplicatedStateRelay에서 정상")

        output.nicknameValid.accept(())
      }

    }).disposed(by: self.disposeBag)
    
    currentNicknameState.subscribe(onNext: { invalidState in
      guard let invalidState = invalidState else {
        print("일반 닉네임 체크에서 정상")

        output.nicknameValid.accept(())
        return
      }
      
      print("일반 닉네임 체크 에러)")
      output.nicknameInvalid.accept(invalidState)
    }).disposed(by: self.disposeBag)

  }
}


struct textViewModel {
  let text: String
  let textColor: UIColor
}
