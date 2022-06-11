//
//  FeedDetailVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/16.
//

import UIKit
import RxSwift

class FeedDetailVC: UIViewController {
  // MARK: - Vars & Lets Part
  private let disposeBag = DisposeBag()
  private var lastContentOffset: CGFloat = 0
  var viewModel: FeedDetailViewModel!
  
  // MARK: - UI Component Part
  @IBOutlet weak var contentScrollView: UIScrollView!
  
  @IBOutlet weak var bookCoverImageView: UIImageView!
  @IBOutlet weak var categoryLabel: UILabel!
  @IBOutlet weak var bookTitleTextView: UITextView!
  @IBOutlet weak var authorLabel: UILabel!
  
  @IBOutlet weak var sentenceTextView: UITextView!
  @IBOutlet weak var seperatorLine: UIView!
  @IBOutlet weak var commentTextView: UITextView!
  
  @IBOutlet weak var nicknameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var detailButton: UIButton!
  
  @IBOutlet weak var sentenceHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var commentHeightConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var headerVIewTopConstraint: NSLayoutConstraint!
  
  // MARK: - Life Cycle Part
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureScrollView()
    self.configureUI()
    self.bindViewModels()
    self.bindButtonAction()
  }
  
  @IBAction func backButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
}

extension FeedDetailVC {
  
  // MARK: - Custom Method Part
  private func bindViewModels() {

    let input = FeedDetailViewModel.Input(

      viewWillAppearEvent:
        self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in })
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)

    output.thumnailURL.asSignal().emit { [weak self] imgURL in
      guard let self = self else { return }
      self.bookCoverImageView.setImage(with: imgURL)
    }.disposed(by: self.disposeBag)
    
    output.categoryName.asSignal().emit { [weak self] category in
      guard let self = self else { return }
      self.categoryLabel.text = category
    }.disposed(by: self.disposeBag)

    output.bookTitle.asSignal().emit { [weak self] titleViewModel in
      guard let self = self else { return }
      self.bookTitleTextView.setTextWithLineHeight(text: titleViewModel.content,
                                                   lineHeightMultiple: titleViewModel.lineHeightMultiple)
      self.bookTitleTextView.font = titleViewModel.textFont
      // 타이틀 높이 먹여줘야 함
    }.disposed(by: self.disposeBag)
    
    output.author.asSignal().emit { [weak self] author in
      guard let self = self else { return }
      self.authorLabel.text = author
    }.disposed(by: self.disposeBag)
    
    output.sentence.asSignal().emit { [weak self] sentenceViewModel in
      guard let self = self else { return }
      self.sentenceTextView.setTextWithLineHeight(text: sentenceViewModel.content,
                                                   lineHeightMultiple: sentenceViewModel.lineHeightMultiple)
      self.sentenceTextView.font = sentenceViewModel.textFont
      self.sentenceHeightConstraint.constant = sentenceViewModel.textViewHeight
      self.sentenceTextView.sizeToFit()
    }.disposed(by: self.disposeBag)
    
    output.comment.asSignal().emit { [weak self] commentViewModel in
      guard let self = self else { return }
      self.commentTextView.setTextWithLineHeight(text: commentViewModel.content,
                                                   lineHeightMultiple: commentViewModel.lineHeightMultiple)
      self.commentTextView.font = commentViewModel.textFont
      self.commentHeightConstraint.constant = commentViewModel.textViewHeight
      self.commentTextView.sizeToFit()
    }.disposed(by: self.disposeBag)
    
    output.nickname.asSignal().emit { [weak self] nickname in
      guard let self = self else { return }
      self.nicknameLabel.text = nickname
    }.disposed(by: self.disposeBag)
    
    output.date.asSignal().emit { [weak self] date in
      guard let self = self else { return }
      self.dateLabel.text = date
    }.disposed(by: self.disposeBag)
    self.view.layoutIfNeeded()
  }
  
  private func bindButtonAction() {
    detailButton.press {
      self.moreButtonTapped()
    }
  }
  
  private func moreButtonTapped() {
    print("CLI")
    let reportVC = ModuleFactory.shared.makeFeedReportVC(isMyPage: false)
    let bottomSheet = BottomSheetVC(contentViewController: reportVC, type: .actionSheet)
    bottomSheet.modalPresentationStyle = .overFullScreen
    bottomSheet.modalTransitionStyle = .crossDissolve
    present(bottomSheet, animated: true)
  }

}

extension FeedDetailVC {
  private func configureScrollView() {
    contentScrollView.delegate = self
  }
  
  private func configureUI() {

    bookCoverImageView.layer.cornerRadius = 2
    
    categoryLabel.textColor = .mainBlue
    categoryLabel.font = UIFont.readMeFont(size: 12, type: .regular)
    
    bookTitleTextView.textContainerInset = .zero
    bookTitleTextView.textContainer.lineFragmentPadding = 0
    bookTitleTextView.textColor = UIColor.grey05
    
    authorLabel.font = UIFont.readMeFont(size: 12, type: .regular)
    authorLabel.textColor = UIColor.init(red: 147/255, green: 147/255, blue: 147/255, alpha: 1)
    
    sentenceTextView.textColor = UIColor.grey05
    sentenceTextView.textContainerInset = .zero
    sentenceTextView.textContainer.lineFragmentPadding = 0
    sentenceTextView.setCharacterSpacing(kernValue: -0.1)
    
    commentTextView.textColor = UIColor.black
    commentTextView.textContainer.lineFragmentPadding = 0
    commentTextView.textContainerInset = .zero
    commentTextView.setCharacterSpacing(kernValue: -0.2)


    nicknameLabel.textColor = UIColor.init(red: 101/255, green: 101/255, blue: 101/255, alpha: 1)
    nicknameLabel.font = UIFont.readMeFont(size: 12, type: .regular)

    dateLabel.textColor = UIColor.grey02
    dateLabel.font = UIFont.readMeFont(size: 12, type: .regular)
  }
  

}

extension FeedDetailVC: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {

      if lastContentOffset > scrollView.contentOffset.y && lastContentOffset < scrollView.contentSize.height - scrollView.frame.height {
          // 스크롤 위로 진행
        showTopBar()
        
        
      } else if lastContentOffset < scrollView.contentOffset.y && scrollView.contentOffset.y > 0 {
          // 스크롤 아래로 진행
        hideTopBar()
        
        
      }

      lastContentOffset = scrollView.contentOffset.y
  }
  
  private func hideTopBar() {
    let safeAreaTopInset = view.safeAreaInsets.top
    headerVIewTopConstraint.constant = -54 - safeAreaTopInset
    UIView.animate(withDuration: 0.5, delay: 0) {
      self.view.layoutIfNeeded()
    }

  }
  
  private func showTopBar() {
    headerVIewTopConstraint.constant = 0
    UIView.animate(withDuration: 0.5, delay: 0) {
      self.view.layoutIfNeeded()
    }
  }
}
