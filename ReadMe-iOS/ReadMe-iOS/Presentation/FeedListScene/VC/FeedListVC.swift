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
  private var refreshEvent = PublishSubject<Bool>()
  private var cachedIndexList: Set<Int> = []
  private var isScrollAnimationRequired = true
  private var currentCategory: [Category] = []
  var isMyPage: Bool = false
  
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
      self.refreshEvent.onNext(self.isMyPage)
      self.cachedIndexList.removeAll()
      self.isScrollAnimationRequired = true
      self.refreshControl.endRefreshing()
    }
  }
  
  private func bindViewModels() {
    let input = FeedListViewModel.Input(
      viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear(_:))).map { _ in },
      refreshEvent: refreshEvent.asObservable(),
      category: category
  )
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
    addObserverAction(.filterButtonClicked) { noti in
      if let category = noti.object as? [Category] {
        self.currentCategory = category
      }
    }

    
    if isMyPage {
      addObserverAction(.deleteFeedForMyPage) { _ in
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
          self.refreshEvent.onNext(true)
        }
      }
    } else {
      addObserverAction(.deleteFeed) { noti in
        self.deleteAction(noti)
      }
    }

    
    addObserverAction(.writeComplete) { _ in
      if self.feedListTV.contentOffset.y > 0 {
        self.feedListTV.scrollToTop()
      }
      self.refreshEvent.onNext(self.isMyPage)
    }
    
    addObserverAction(.report) { noti in
      guard let nickname = noti.userInfo?["nickname"] as? String else { return }
      guard let feedId = noti.userInfo?["feedId"] as? String else { return }
      
      if MFMailComposeViewController.canSendMail() {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self

        mailComposeVC.setToRecipients(["Readme.team.sopterm@gmail.com"])
        mailComposeVC.setSubject("리드미 유저 신고")
        mailComposeVC.setMessageBody("""
        ❗️이곳은 수정하지 말아주세요❗️
        신고할 유저의 닉네임 : \(nickname)
        신고할 게시글의 id : \(feedId)
        
        🚨신고 유형 사유가 무엇인가요?
         ex) 상업적 광고 및 판매, 음란물/불건전한 대화, 욕설 비하, 도배, 부적절한 내용, 기타사유 등
        신고하신 사항은 리드미팀이 신속하게 처리하겠습니다. 감사합니다.
        
        
        
        ----------------------------------------------------------------------
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
  
  private func deleteAction(_ noti: Notification) {
    print("DELETE ACTION IN FEEDLISTVC")
    if let idx = noti.object as? String {
      self.makeAlert(title: "알림", message: "피드를 삭제하시겠습니까?", cancelButtonNeeded: true) { _ in
        BaseService.default.deleteFeed(idx: idx) { result in
          self.makeAlert(message: "삭제가 완료되었습니다.")
          self.refreshEvent.onNext(false)
          self.cachedIndexList.removeAll()
          self.isScrollAnimationRequired = true
        }
      }
    }
  }
}

extension FeedListVC: FeedCategoryDelegate {
  func categoryButtonTapped() {
    let filterVC = ModuleFactory.shared.makeFilterVC(category: currentCategory)
    let bottomSheet = BottomSheetVC(contentViewController: filterVC)
    filterVC.buttonDelegate = bottomSheet
    bottomSheet.modalPresentationStyle = .overFullScreen
    bottomSheet.modalTransitionStyle = .crossDissolve
    present(bottomSheet, animated: true)
  }
}

extension FeedListVC: FeedListDelegate {
  func moreButtonTapped(nickname: String? = nil, feedId: String? = nil) {
    let userNickname = UserDefaults.standard.string(forKey: UserDefaultKeyList.Auth.userNickname)
    let reportVC = ModuleFactory.shared.makeFeedReportVC(isMyPage: userNickname == nickname, nickname: nickname ?? "", feedId: feedId ?? "")
    let bottomSheet = BottomSheetVC(contentViewController: reportVC, type: .actionSheet)
    reportVC.buttonDelegate = bottomSheet
    bottomSheet.modalPresentationStyle = .overFullScreen
    bottomSheet.modalTransitionStyle = .crossDissolve
    present(bottomSheet, animated: true)
  }
}

extension FeedListVC: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cachedIndexList.insert(indexPath.row)
  }
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let lastIndexPath = indexPath
      guard lastIndexPath.row != 0 else {return}
      guard cell.className != FeedListEmptyTVC.className else { return }

      guard isScrollAnimationRequired else { return }
      guard !cachedIndexList.contains(lastIndexPath.row) else {return}
      cachedIndexList.insert(lastIndexPath.row)

        if lastIndexPath.row <= indexPath.row{
          cell.frame.origin.x = -cell.frame.width
          UIView.animate(withDuration: 1.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.allowUserInteraction,.curveEaseOut], animations: {
              cell.frame.origin.x = 0
          }, completion: nil)
        }

  }
}

extension FeedListVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            controller.dismiss(animated: true) { self.makeAlert(message: "신고가 취소되었습니다.") }
        case .sent:
            controller.dismiss(animated: true) {  self.makeAlert(message: "신고가 접수되었습니다.") }
        case .failed:
            controller.dismiss(animated: true) { self.makeAlert(message: "네트워크 상태를 확인해주세요.")}
        default:
            return
        }
    }
}
