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

class FeedListVC: UIViewController {
  // MARK: - Vars & Lets Part
  
  private let disposeBag = DisposeBag()
  private var category = PublishSubject<[FeedCategory]>()
  var viewModel: FeedListViewModel!
  
  // MARK: - UI Component Part
  
  @IBOutlet weak var feedListTV: UITableView!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindCells()
    self.configureTableView()
    self.bindViewModels()
  }
}

extension FeedListVC {
  private func bindCells() {
    FeedListCategoryTVC.register(target: feedListTV)
    FeedListContentTVC.register(target: feedListTV)
  }
  
  private func configureTableView() {
    feedListTV.separatorStyle = .none
    feedListTV.backgroundColor = .clear
    feedListTV.allowsSelection = false
    feedListTV.showsVerticalScrollIndicator = false
  }
  
  private func bindViewModels() {
    let input = FeedListViewModel.Input(
      viewWillAppearEvent: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in },
      category: category)
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
    
    output.scrollToTop.asSignal()
      .emit(onNext: { [weak self] in
        guard let self = self else { return }
        self.feedListTV.scrollToTop()
      })
      .disposed(by: self.disposeBag)
    
    output.feedList
      .bind(to: feedListTV.rx.items) { (tableView,index,item) -> UITableViewCell in
        switch(item.type) {
          case .category:
            let categoryData = item.dataSource as! FeedCategoryViewModel
            guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: FeedListCategoryTVC.className) as? FeedListCategoryTVC else { return UITableViewCell() }

            categoryCell.viewModel = categoryData
            return categoryCell
          case .content :
            let contentData = item.dataSource as! FeedListContentViewModel
            guard let contentCell = tableView.dequeueReusableCell(withIdentifier: FeedListContentTVC.className) as? FeedListContentTVC else { return UITableViewCell() }

            contentCell.viewModel = contentData
            return contentCell

            

        }
      }.disposed(by: self.disposeBag)
  }
}
