//
//  SearchUseCase.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/14.
//

import RxSwift

protocol SearchUseCase {
  
}

final class DefaultSearchUseCase {
  
  private let repository: SearchRepository
  private let disposeBag = DisposeBag()
  
  init(repository: SearchRepository) {
    self.repository = repository
  }
}

extension DefaultSearchUseCase: SearchUseCase {
  
}
