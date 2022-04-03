//
//  SampleRepository.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/03.
//

import RxSwift

protocol SampleRepository {
  
}

final class DefaultSampleRepository {
  
  private let disposeBag = DisposeBag()

  init() {
    
  }
}

extension DefaultSampleRepository: SampleRepository {
  
}
