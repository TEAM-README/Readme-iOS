//
//  SampleUsecase.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/03.
//

import RxSwift

protocol SampleUseCase {

}

final class DefaultSampleUseCase {
  
  private let repository: SampleRepository
  private let disposeBag = DisposeBag()
  
  init(repository: SampleRepository) {
    self.repository = repository
  }
}

extension DefaultSampleUseCase: SampleUseCase {
  
}
