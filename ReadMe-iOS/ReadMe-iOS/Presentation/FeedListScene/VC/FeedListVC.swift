//
//  FeedListVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/18.
//

import UIKit
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
    self.bindCells()
    self.configureTableView()
    self.bindViewModels()
    self.bindTableView()
    self.configureRefreshControl()
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
