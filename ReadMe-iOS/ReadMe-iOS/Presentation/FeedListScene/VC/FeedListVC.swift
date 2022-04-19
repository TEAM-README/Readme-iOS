//
//  FeedListVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/18.
//

import UIKit
import RxSwift

class FeedListVC: UIViewController {
  // MARK: - Vars & Lets Part
  
  private let disposeBag = DisposeBag()
  var viewModel: FeedListViewModel!
  
  // MARK: - UI Component Part
  
  @IBOutlet weak var feedListTV: UITableView!
  
  // MARK: - Life Cycle Part
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindViewModels()
  }
}

extension FeedListVC {
  
  // MARK: - Custom Method Part
  private func bindViewModels() {
    let input = FeedListViewModel.Input(viewWillAppearEvent: <#T##Observable<Void>#>,
                                        category: <#T##Observable<FeedCategory>#>)
    let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
  }
}
