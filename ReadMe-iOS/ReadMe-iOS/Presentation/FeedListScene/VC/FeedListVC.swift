//
//  FeedListVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/18.
//

import UIKit

import MessageUI
import RxSwift
import RxRelay
import RxCocoa
import SnapKit

final class FeedListVC: UIViewController {
  // MARK: - Vars & Lets Part
  
  private let disposeBag = DisposeBag()
  private let refreshControl = UIRefreshControl()
  private var category = PublishSubject<[FeedCategory]>()
  private var isMyPage: Bool = false
  private var cachedIndexList: Set<IndexPath> = []
  private var isScrollAnimationRequired = true
  var viewModel: FeedListViewModel!
  
  // MARK: - UI Component Part
  
  @IBOutlet weak var feedListTV: UITableView!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.feedListTV.alpha = 0
    self.bindCells()
    self.configureTableView()
    self.bindViewModels()
    self.bindTableView()
    self.configureRefreshControl()
    self.addObserver()
  }
  override func viewWillAppear(_ animated: Bool) {
    UIView.animate(withDuration: 0.5, delay: 0) {
      self.feedListTV.alpha = 1
    }
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    self.isScrollAnimationRequired = false
  }
}

extension FeedListVC {
  private func bindCells() {
    FeedListContentTVC.register(target: feedListTV)
    FeedListEmptyTVC.register(target: feedListTV)
  }
  
  private func configureTableView() {
    feedListTV.separatorStyle = .none
    feedListTV.backgroundColor = .clear
    feedListTV.showsVerticalScrollIndicator = false
    feedListTV.delegate = self
  }
  
  private func configureRefreshControl() {
    refreshControl.endRefreshing()
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    feedListTV.refreshControl = refreshControl
  }
  
  @objc func refresh() {
    delayWithSeconds(1.0) {
      self.cachedIndexList.removeAll()
      self.isScrollAnimationRequired = true
      self.feedListTV.reloadData()
      self.refreshControl.endRefreshing()
    }
  }
  
  private func bindViewModels() {
    let input = FeedListViewModel.Input(
      viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in },
      category: category)
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    
    output.isMyPageMode.asSignal()
      .emit(onNext: { [weak self] isMyPage in
        guard let self = self else { return }
        self.isMyPage = isMyPage
        if isMyPage {
          MyPageHeaderTVC.register(target: self.feedListTV)
          self.view.backgroundColor = .subBlue
        }else {
          FeedListCategoryTVC.register(target:
                                        self.feedListTV)
          self.view.backgroundColor = .grey00
        }
      })
      .disposed(by: self.disposeBag)
    
    output.scrollToTop.asSignal()
      .emit(onNext: { [weak self] in
        guard let self = self else { return }
        if self.feedListTV.contentOffset.y > 0 {
          self.feedListTV.scrollToTop()
        }
      })
      .disposed(by: self.disposeBag)
    
    output.feedList
      .bind(to: feedListTV.rx.items) { (tableView,index,item) -> UITableViewCell in
        switch(item.type) {
            
          case .myPageHeader:
            let myPageData = item.dataSource as! MyPageModel
            guard let myPageHeaderCell = tableView.dequeueReusableCell(withIdentifier: MyPageHeaderTVC.className) as? MyPageHeaderTVC else { return UITableViewCell() }
            myPageHeaderCell.viewModel = myPageData
            return myPageHeaderCell
            
          case .category:
            let categoryData = item.dataSource as! FeedCategoryViewModel
            guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: FeedListCategoryTVC.className) as? FeedListCategoryTVC else { return UITableViewCell() }

            categoryCell.viewModel = categoryData
            categoryCell.buttonDelegate = self
            return categoryCell
            
          case .content :
            let contentData = item.dataSource as! FeedListContentViewModel
            guard let contentCell = tableView.dequeueReusableCell(withIdentifier: FeedListContentTVC.className) as? FeedListContentTVC else { return UITableViewCell() }

            contentCell.viewModel = contentData
            contentCell.buttonDelegate = self
            return contentCell

          case .empty:
            let contentData = item.dataSource as! FeedListEmtpyViewData
            guard let emptyCell = tableView.dequeueReusableCell(withIdentifier: FeedListEmptyTVC.className) as? FeedListEmptyTVC else { return UITableViewCell() }
            emptyCell.isMyPage = contentData.isMyPage
            emptyCell.backgroundColor = .clear
            emptyCell.selectionStyle = .none
            emptyCell.cellHeight = self.feedListTV.frame.height - 104
            return emptyCell
        }
      }.disposed(by: self.disposeBag)
  }
  
  private func bindTableView() {
    feedListTV.rx.modelAndIndexSelected(FeedListDataModel.self)
      .subscribe(onNext: { [weak self] (model,index) in
        guard let self = self else { return }
        if model.type == .category { self.categoryButtonTapped() }
        guard model.type == .content else { return }
        let selectedModel = model.dataSource as! FeedListContentViewModel
        self.postObserverAction(.moveFeedDetail, object: selectedModel.idx)
      }).disposed(by: self.disposeBag)
  }
  
  private func addObserver() {
    addObserverAction(.report) { noti in
      guard let nickname = noti.userInfo?["nickname"] as? String else { return }
      guard let feedId = noti.userInfo?["feedId"] as? String else { return }
      
      if MFMailComposeViewController.canSendMail() {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self

        mailComposeVC.setToRecipients(["Readme.team.sopterm@gmail.com"])
        mailComposeVC.setSubject("리드미 유저 신고")
        mailComposeVC.setMessageBody("""
        
        🚨신고 유형 사유가 무엇인가요?
         ex) 상업적 광고 및 판매, 음란물/불건전한 대화, 욕설 비하, 도배, 부적절한 내용, 기타사유 등
        신고하신 사항은 리드미팀이 신속하게 처리하겠습니다. 감사합니다
        ----------------------------------------------------------------------
        ❗️이곳은 수정하지 말아주세요❗️
        신고할 유저의 닉네임 : \(nickname)
        신고할 게시글의 id : \(feedId)
        """,
                                     isHTML: false)

        self.present(mailComposeVC, animated: true, completion: nil)
      } else {
        // 메일이 계정과 연동되지 않은 경우.
        let mailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in }
        mailErrorAlert.addAction(confirmAction)
        self.present(mailErrorAlert, animated: true, completion: nil)
      }
    }
  }
}

extension FeedListVC: FeedCategoryDelegate {
  func categoryButtonTapped() {
    let filterVC = ModuleFactory.shared.makeFilterVC()
    let bottomSheet = BottomSheetVC(contentViewController: filterVC)
    filterVC.buttonDelegate = bottomSheet
    bottomSheet.modalPresentationStyle = .overFullScreen
    bottomSheet.modalTransitionStyle = .crossDissolve
    present(bottomSheet, animated: true)
  }
}

extension FeedListVC: FeedListDelegate {
  func moreButtonTapped() {
    let reportVC = ModuleFactory.shared.makeFeedReportVC(isMyPage: self.isMyPage)
    let bottomSheet = BottomSheetVC(contentViewController: reportVC, type: .actionSheet)
    // TODO: - feedId, user.nickname 넘겨줘야됨
    reportVC.buttonDelegate = bottomSheet
    bottomSheet.modalPresentationStyle = .overFullScreen
    bottomSheet.modalTransitionStyle = .crossDissolve
    present(bottomSheet, animated: true)
  }
}

extension FeedListVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    if let lastIndexPath = tableView.indexPathsForVisibleRows?.first{
      guard lastIndexPath.row != 0 else {return}
      guard isScrollAnimationRequired else { return }
      guard !cachedIndexList.contains(lastIndexPath) else {return}
      cachedIndexList.insert(lastIndexPath)

        if lastIndexPath.row <= indexPath.row{
          cell.frame.origin.x = -cell.frame.width
          UIView.animate(withDuration: 1.3, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.allowUserInteraction,.curveEaseOut], animations: {
              cell.frame.origin.x = 0
          }, completion: nil)
        }
    }

  }
}

extension FeedListVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            controller.dismiss(animated: true) { print("mailComposeController - cancelled.")}
        case .saved:
            controller.dismiss(animated: true) { print("mailComposeController - saved.")}
        case .sent:
            controller.dismiss(animated: true) {
                print("📍 mailComposeController - sent.")
            }
        case .failed:
            controller.dismiss(animated: true) { print("mailComposeController - filed.")}
        @unknown default:
            return
        }
    }
}
