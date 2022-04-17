//
//  FeedDetailViewModel.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/16.
//

import RxSwift
import RxRelay

final class FeedDetailViewModel: ViewModelType {

  private let useCase: FeedDetailUseCase
  private let feedDetailIdx: Int
  private let disposeBag = DisposeBag()
  
  // MARK: - Inputs
  struct Input {
    let viewWillAppearEvent: Observable<Void>
  }
  
  // MARK: - Outputs
  struct Output {
    var thumnailURL = PublishRelay<String>()
    var categoryName = PublishRelay<String>()
    var bookTitle = PublishRelay<FeedTextViewModel>()
    var author = PublishRelay<String>()
    var sentence = PublishRelay<FeedTextViewModel>()
    var comment = PublishRelay<FeedTextViewModel>()
    var nickname = PublishRelay<String>()
    var date = PublishRelay<String>()
  }
  
  init(useCase: FeedDetailUseCase,idx: Int) {
    self.useCase = useCase
    self.feedDetailIdx = idx
  }
}

extension FeedDetailViewModel {
  func transform(from input: Input, disposeBag: DisposeBag) -> Output {
    let output = Output()
    self.bindOutput(output: output, disposeBag: disposeBag)
    input.viewWillAppearEvent.subscribe(onNext: { [weak self] in
      guard let self = self else { return }
      self.useCase.getBookDetailInformation(idx: self.feedDetailIdx)
    }).disposed(by: self.disposeBag)
    
    return output
  }
  
  private func bindOutput(output: Output, disposeBag: DisposeBag) {
    let feedDetailRelay = useCase.bookDetailInformation
    
    feedDetailRelay.subscribe(onNext: { [weak self] model in
      guard let self = self else { return }
      output.thumnailURL.accept(model.imgURL)
      output.categoryName.accept(model.category)
      output.author.accept(model.author)
      output.bookTitle.accept(self.makeTextViewModel(type: .title, text: model.title))
      output.sentence.accept(self.makeTextViewModel(type: .sentence, text: model.sentence))
      output.comment.accept(self.makeTextViewModel(type: .comment, text: model.comment))
      output.nickname.accept(model.nickname)
      output.date.accept(model.date)
    }).disposed(by: self.disposeBag)
  }
}

extension FeedDetailViewModel {
  private func makeTextViewModel(type : FeedDetailTextType, text: String) -> FeedTextViewModel{
    let font: UIFont
    let lineHeightMultiple: CGFloat
    let textViewWidth: CGFloat
    
    switch(type) {
      case .title:
        font = .readMeFont(size: 13, type: .medium)
        lineHeightMultiple = 1.23
        textViewWidth = screenWidth - 164
      case .sentence:
        font = .readMeFont(size: 13, type: .regular)
        lineHeightMultiple = 1.33
        textViewWidth = screenWidth - 56
      case .comment:
        font = .readMeFont(size: 14, type: .extraLight)
        lineHeightMultiple = 1.33
        textViewWidth = screenWidth - 56
    }
    let textHeight = calculateTextViewHeight(width: textViewWidth,
                                             font: font,
                                             lineHeightMultiple: lineHeightMultiple,
                                             text: text)
    
    return FeedTextViewModel(textFont: font,
                             lineHeightMultiple: lineHeightMultiple,
                             textViewHeight: textHeight,
                             content: text)
  }
  
  private func calculateTextViewHeight(width: CGFloat,font: UIFont, lineHeightMultiple: CGFloat, text: String) -> CGFloat {
    let mockTextView = UITextView()
    let newSize = CGSize(width: width, height: CGFloat.infinity)
    mockTextView.textContainerInset = .zero
    mockTextView.textContainer.lineFragmentPadding = 0
    mockTextView.setTextWithLineHeight(text: text, lineHeightMultiple: lineHeightMultiple)
    mockTextView.isScrollEnabled = false
    mockTextView.translatesAutoresizingMaskIntoConstraints = false
    mockTextView.font = font
    let estimatedSize = mockTextView.sizeThatFits(newSize)
    return estimatedSize.height
  }
}


struct FeedTextViewModel {
  let textFont: UIFont
  let lineHeightMultiple: CGFloat
  let textViewHeight: CGFloat
  let content: String
}

enum FeedDetailTextType {
  case title
  case sentence
  case comment
}
