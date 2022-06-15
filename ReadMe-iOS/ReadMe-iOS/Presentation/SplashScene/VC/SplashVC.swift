//
//  SplashVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/13.
//

import UIKit

class SplashVC: UIViewController {
  @IBOutlet weak var spalshIconView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    UserDefaults.standard.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0eXBlIjoiYWNjZXNzVG9rZW4iLCJpZCI6MTQsIm5pY2tuYW1lIjoi66as65Oc66-4IiwiaWF0IjoxNjU1Mjg0MzI1LCJleHAiOjE2NTUyODc5MjV9.xdIfljm4ShKC_1f4wfA6co-XP-TGFtnna2eo6QBumDw", forKey: "authorization")
    delayWithSeconds(1) {
      UIView.animate(withDuration: 1.0, delay: 0) {
        self.spalshIconView.alpha = 0
      } completion: { _ in
        self.checkOnboardingState() ? self.pushBaseView() : self.pushOnboardingView()
      }
    }
  }
  
  private func checkOnboardingState() -> Bool {
    guard let state = UserDefaults.standard.value(forKey: UserDefaultKeyList.Onboarding.onboardingComplete) as? Bool else { return false }
    return state
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
  
  private func pushFilterView() {
    let filterVC = BottomSheetVC(contentViewController: ModuleFactory.shared.makeFilterVC())
    filterVC.modalPresentationStyle = .overFullScreen
    present(filterVC, animated: true)
  }
  
  private func presentFeedReportView() {
    let feedReportVC = BottomSheetVC(contentViewController: ModuleFactory.shared.makeFeedReportVC(isMyPage: false), type: .actionSheet)
    feedReportVC.modalPresentationStyle = .overFullScreen
    present(feedReportVC, animated: true)
  }
  
  private func pushWriteView() {
    let bookInfo = WriteModel.init(bookcover: "-", bookname: "-", category: "-", author: "-")
    let writeVC = ModuleFactory.shared.makeWriteVC(bookInfo: bookInfo)
    navigationController?.pushViewController(writeVC, animated: false)
  }
  
  private func pushWriteCheckView() {
    let writeInfo = WriteCheckModel.init(bookCover: "-", bookTitle: "-", bookAuthor: "-", bookCategory: "-", quote: "-", impression: "-")
    let writeCheckVC = ModuleFactory.shared.makeWriteCheckVC(writeInfo: writeInfo)
    navigationController?.pushViewController(writeCheckVC, animated: false)
  }
  
  private func pushWriteCompleteView() {
    let writeCompleteVC = ModuleFactory.shared.makeWriteCompleteVC()
    navigationController?.pushViewController(writeCompleteVC, animated: false)
  }
  
  private func pushOnboardingView() {
    let onboardingVC = ModuleFactory.shared.makeOnboardingVC()
    navigationController?.pushViewController(onboardingVC, animated: false)
  }
  
  private func presentAlertVC() {
    let alertVC = ModuleFactory.shared.makeAlertVC()
    alertVC.modalPresentationStyle = .fullScreen
    alertVC.modalTransitionStyle = .crossDissolve
    alertVC.setAlertTitle(title: I18N.ReadmeAlert.title, description: I18N.ReadmeAlert.description)
    alertVC.setAlertType(.twoAction, action: I18N.ReadmeAlert.cancel, I18N.ReadmeAlert.ok)
    alertVC.closure = {
      self.pushSearchView()
    }
    
    present(alertVC, animated: true)
  }
}
