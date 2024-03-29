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
    let textEditFinished: Observable<String?>
  }
  
  // MARK: - Outputs
  struct Output {
    var recentList = PublishRelay<[SearchBookModel]>()
    var searchList = PublishRelay<[SearchBookModel]>()
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
    
//    input.queryText
//      .filter { $0 != nil }
//      .filter { $0 != "" }
//      .subscribe(onNext: { [weak self] queryStr in
//        guard let self = self else { return }
//        self.useCase.se
//        
//      }).disposed(by: self.disposeBag)
                 
    input.textEditFinished
      .filter { $0 != nil }
      .filter { $0 != "" }
      .subscribe(onNext: { [weak self] queryStr in
        guard let self = self else { return }
        self.useCase.getSearchResultInformation(query: queryStr!)
      })
      .disposed(by: self.disposeBag)
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    let recentRelay = useCase.searchRecentInformation
    let resultRelay = useCase.searchResultInformation
    
    recentRelay.subscribe(onNext: { model in
      output.recentList.accept(model)
    })
    .disposed(by: self.disposeBag)
    
    resultRelay.subscribe(onNext: { model in
      var dataModel: [SearchBookModel] = []
      
      for item in model {
        dataModel.append(self.makeNewBookModel(book: item))
      }
      output.searchList.accept(dataModel)
    })
    .disposed(by: self.disposeBag)
  }
  
  private func makeNewBookModel(book: SearchBookModel) -> SearchBookModel {
    return SearchBookModel.init(imgURL: book.imgURL,
                                title: removeBoldCharcater(book.title),
                                author: removeBoldCharcater(book.author),
                                isbn: book.isbn)
  }
  
  private func removeBoldCharcater(_ str: String) -> String {
    return str.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
  }
}
