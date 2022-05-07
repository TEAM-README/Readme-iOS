//
//  WriteCompleteUseCase.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/22.
//

import RxSwift

protocol WriteCompleteUseCase {

}

final class DefaultWriteCompleteUseCase {
  
  private let disposeBag = DisposeBag()
  
  init() {
    
  }
}

extension DefaultWriteCompleteUseCase: WriteCompleteUseCase {
  
}
