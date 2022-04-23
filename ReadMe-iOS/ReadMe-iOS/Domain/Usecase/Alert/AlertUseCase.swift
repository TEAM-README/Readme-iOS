//
//  AlertUseCase.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/24.
//

import RxSwift
import RxRelay

protocol AlertUseCase {
  
}

final class DefaultAlertUseCase {
  
  private let disposeBag = DisposeBag()
  
  init() {
    
  }
}

extension DefaultAlertUseCase: AlertUseCase {
  
}

