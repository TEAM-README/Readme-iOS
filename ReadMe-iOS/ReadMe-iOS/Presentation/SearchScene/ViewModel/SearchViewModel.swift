//
//  SearchViewModel.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/04/14.
//

import RxSwift
import RxRelay

final class SearchViewModel: ViewModelType {
  
  private let useCase: SearchUseCase
  private let disposeBag = DisposeBag()
  
  // MARK: - Inputs
  struct Input {
    let viewWillAppearEvent: Observable<Void>
//    let searchText: Observable<String?>
  }
  
  // MARK: - Outputs
  struct Output {
    var contentList = PublishRelay<[SearchBookModel]>()
  }
  
  init(useCase: SearchUseCase) {
    self.useCase = useCase
  }
}

extension SearchViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    
    input.viewWillAppearEvent.subscribe(onNext: { [weak self] in
      guard let self = self else { return }
      self.useCase.getSearchRecentInformation()
    })
    .disposed(by: disposeBag)
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    let searchRecentRelay = useCase.searchResultInformation
    
    searchRecentRelay.subscribe(onNext: { model in
      output.contentList.accept(model)
    })
    .disposed(by: self.disposeBag)
  }
}
