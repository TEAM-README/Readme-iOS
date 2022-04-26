//
//  SplashVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/13.
//

import UIKit

class SplashVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delayWithSeconds(1) {
//      self.pushSignupView()
      self.pushSearchView()
    }
  }
  
  private func pushLoginView() {
    let loginVC = ModuleFactory.shared.makeLoginVC()
    navigationController?.pushViewController(loginVC, animated: false)
  }
  
  private func pushSignupView() {
    let signupVC = ModuleFactory.shared.makeSignupVC()
    navigationController?.pushViewController(signupVC, animated: false)
  }
  
  private func pushFeedDetailView() {
    let feedDetailVC = ModuleFactory.shared.makeFeedDetailVC(idx: 0)
    navigationController?.pushViewController(feedDetailVC, animated: false)
  }
  
  private func pushSearchView() {
    let searchVC = ModuleFactory.shared.makeSearchVC()
    navigationController?.pushViewController(searchVC, animated: false)
  }
  
  private func pushBaseView() {
    let baseVC = ModuleFactory.shared.makeBaseVC()
    navigationController?.pushViewController(baseVC, animated: false)
  }
  
  private func pushFeedListView() {
    let feedListVC = ModuleFactory.shared.makeFeedListVC(isMyPage: false)
    navigationController?.pushViewController(feedListVC, animated: false)
  }
  
  private func pushWriteView() {
    let bookInfo = WriteModel.init(bookcover: "-", bookname: "-", category: "-", author: "-")
    let writeVC = ModuleFactory.shared.makeWriteVC(bookInfo: bookInfo)
    navigationController?.pushViewController(writeVC, animated: false)
  }
  
  private func pushWriteCheckView() {
    let writeCheckVC = ModuleFactory.shared.makeWriteCheckVC()
    navigationController?.pushViewController(writeCheckVC, animated: false)
  }
}
