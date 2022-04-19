//
//  FeedDetailUseCase.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/16.
//

import RxSwift
import RxRelay

protocol FeedDetailUseCase {
  func getBookDetailInformation(idx: Int)
  var bookDetailInformation: PublishRelay<FeedDetailModel> { get set }
}

final class DefaultFeedDetailUseCase {
  
  private let repository: FeedRepository
  private let disposeBag = DisposeBag()
  var bookDetailInformation = PublishRelay<FeedDetailModel>()
  
  init(repository: FeedRepository) {
    self.repository = repository
  }
}

extension DefaultFeedDetailUseCase: FeedDetailUseCase {
  func getBookDetailInformation(idx: Int) {
    repository.getBookDetailInformation(idx: idx)
      .filter{ $0 != nil }
      .subscribe(onNext: { [weak self] entity in
        guard let self = self else { return }
        let model = entity!.toDomain()
        self.bookDetailInformation.accept(model)
      }).disposed(by: self.disposeBag)
  }
}
