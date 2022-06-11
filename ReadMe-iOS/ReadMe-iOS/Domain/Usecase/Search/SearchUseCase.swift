//
//  SearchUseCase.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/14.
//

import RxSwift
import RxRelay

protocol SearchUseCase {
  func getSearchResultInformation(query: String, display: Int, start: Int, sort: String)
  func getSearchRecentInformation()
  var searchRecentInformation: PublishRelay<[SearchBookModel]> { get set }
  var searchResultInformation: PublishRelay<[SearchBookModel]> { get set }
}

final class DefaultSearchUseCase {
  
  private let repository: SearchRepository
  private let disposeBag = DisposeBag()
  var searchRecentInformation = PublishRelay<[SearchBookModel]>()
  var searchResultInformation = PublishRelay<[SearchBookModel]>()
  
  init(repository: SearchRepository) {
    self.repository = repository
  }
}

extension DefaultSearchUseCase: SearchUseCase {
  func getSearchResultInformation(query: String, display: Int, start: Int, sort: String) {
    repository.getSearchResult(query: query, display: display, start: start, sort: sort)
      .subscribe(onNext: { [weak self] entity in
        guard let self = self else { return }
        guard let entity = entity else { return }
        let model = entity.toDomain()
        print("👣 model: \(model.content)")
        self.searchResultInformation.accept(model.content)
      })
      .disposed(by: disposeBag)
  }
  
  func getSearchRecentInformation() {
    repository.getSearchRecentResult()
      .subscribe(onNext: { [weak self] entity in
        guard let self = self else { return }
        guard let entity = entity else { return }
        let model = entity.toDomain()
        self.searchRecentInformation.accept(model.content)
      })
      .disposed(by: disposeBag)
  }
}
