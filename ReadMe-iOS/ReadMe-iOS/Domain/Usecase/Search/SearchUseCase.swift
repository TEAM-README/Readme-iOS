//
//  SearchUseCase.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/14.
//

import RxSwift
import RxRelay

protocol SearchUseCase {
  func getSearchRecentInformation()
  var searchResultInformation: PublishRelay<[SearchBookModel]> { get set }
}

final class DefaultSearchUseCase {
  
  private let repository: SearchRepository
  private let disposeBag = DisposeBag()
  var searchResultInformation = PublishRelay<[SearchBookModel]>()
  
  init(repository: SearchRepository) {
    self.repository = repository
  }
}

extension DefaultSearchUseCase: SearchUseCase {
  func getSearchRecentInformation() {
    repository.getSearchBookInformation()
      .subscribe(onNext: { [weak self] entity in
        guard let self = self else { return }
        let model = entity!.toDomain()
        self.searchResultInformation.accept(model.content)
      })
      .disposed(by: disposeBag)
  }
}
