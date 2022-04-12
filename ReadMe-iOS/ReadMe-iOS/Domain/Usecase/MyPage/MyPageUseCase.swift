//
//  MyPageUseCase.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/12.
//

import RxSwift

protocol MyPageUseCase {

}

final class DefaultMyPageUseCase {
  
  private let repository: MyPageRepository
  private let disposeBag = DisposeBag()
  
  init(repository: MyPageRepository) {
    self.repository = repository
  }
}

extension DefaultMyPageUseCase: MyPageUseCase {
  
}
