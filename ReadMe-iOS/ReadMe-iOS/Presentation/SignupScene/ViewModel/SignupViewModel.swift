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
  private let maxCount = 7
  
  // MARK: - Inputs
  struct Input {
    let nicknameText: Observable<String?>
    let duplicateCheckClicked: Observable<String?>
    let completeButtonClicked: Observable<SignupDTO>
  }
  
  // MARK: - Outputs
  struct Output {
    var nicknameInvalid = PublishRelay<NicknameInvalidType>()
    var nicknameValid = PublishRelay<Void>()
    var countingLabelText = PublishRelay<String>()
    var nicknameDuplicatedCheckButtonState = BehaviorRelay<Bool>(value: false)
    var signupComplete = PublishRelay<Bool>()
    var nicknameNotDuplicated = PublishRelay<Void>()
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
        if nickname!.count > 1 && nickname!.count <= 7{
          output.nicknameDuplicatedCheckButtonState.accept(true)
        }
        self.useCase.checkNicknameExceed(nickname: nickname!)
        self.useCase.checkNicknameHasCharacter(nickname: nickname!)
        output.countingLabelText.accept("\(nickname!.count)/\(self.maxCount)")
      }).disposed(by: self.disposeBag)
        
    input.duplicateCheckClicked
      .filter{$0 != nil}
      .filter{$0 != ""}
      .subscribe(onNext: { [weak self] nickname in
        guard let self = self else { return }
        self.useCase.checkNicknameDuplicated(nickname: nickname!)
      }).disposed(by: self.disposeBag)
    
    input.completeButtonClicked
      .subscribe(onNext: { [weak self] data in
        guard let self = self else { return }
        self.useCase.postUserSignup(data: data)
      }).disposed(by: self.disposeBag)
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    let duplicatedStateRelay = useCase.nicknameDuplicated
    let hasCharacterRelay = useCase.nicknameHasCharacter
    let didExceededRelay = useCase.nicknameExceeded
    let signupState = useCase.signupState
    
    let currentNicknameState = Observable.combineLatest(hasCharacterRelay,didExceededRelay) { hasCharacter, didExceeded -> NicknameInvalidType? in
      output.nicknameDuplicatedCheckButtonState.accept(false)
      if didExceeded { return .exceedMaxCount }
      else if hasCharacter { return .hasCharacter }
      else { return .none }
    }
    
    duplicatedStateRelay.subscribe(onNext: { isDuplicated in
      print("AVAILABLE",isDuplicated)
      if isDuplicated {
        output.nicknameDuplicatedCheckButtonState.accept(false)
        output.nicknameInvalid.accept(.nicknameDuplicated)
      }else {
        output.nicknameNotDuplicated.accept(())
      }

    }).disposed(by: self.disposeBag)
    
    currentNicknameState.subscribe(onNext: { invalidState in
      guard let invalidState = invalidState else {
        output.nicknameValid.accept(())
        return
      }
      output.nicknameInvalid.accept(invalidState)
    }).disposed(by: self.disposeBag)


    signupState.subscribe(onNext: { state in
      output.signupComplete.accept(state)
    }).disposed(by: self.disposeBag)
  }
}


struct textViewModel {
  let text: String
  let textColor: UIColor
}
