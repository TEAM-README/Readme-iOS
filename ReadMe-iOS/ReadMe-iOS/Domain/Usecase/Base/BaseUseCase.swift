//
//  BaseUseCase.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import RxSwift

protocol BaseUseCase {

}

final class DefaultBaseUseCase {
  
  private let disposeBag = DisposeBag()
  
}

extension DefaultBaseUseCase: BaseUseCase {
  
}
