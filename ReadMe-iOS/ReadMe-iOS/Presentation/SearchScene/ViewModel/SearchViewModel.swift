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
  private let displayCount = 10
  private let startNum = 1
  private let sortType = "sim"
  
  // MARK: - Inputs
  struct Input {
    let viewWillAppearEvent: Observable<Void>
    let textEditFinished: Observable<String?>
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
        self.useCase.getSearchResultInformation(query: queryStr!, display: self.displayCount, start: self.startNum, sort: self.sortType)
      })
      .disposed(by: self.disposeBag)
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    let searchRecentRelay = useCase.searchResultInformation
    
    searchRecentRelay.subscribe(onNext: { model in
      var dataModel: [SearchBookModel] = []
      
      for item in model {
        dataModel.append(self.makeNewBookModel(book: item))
      }
      output.contentList.accept(dataModel)
    })
    .disposed(by: self.disposeBag)
  }
  
  private func makeNewBookModel(book: SearchBookModel) -> SearchBookModel {
    return SearchBookModel.init(imgURL: book.imgURL,
                                title: removeBoldCharcater(book.title),
                                author: removeBoldCharcater(book.author))
  }
  
  private func removeBoldCharcater(_ str: String) -> String {
    var newStr: String = ""
    newStr = str
      .replacingOccurrences(of: "<b>", with: "")
      .replacingOccurrences(of: "</b>", with: "")
    
    return newStr
  }
}
