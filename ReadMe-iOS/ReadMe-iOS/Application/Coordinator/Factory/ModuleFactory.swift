//
//  ModuleFactory.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/30.
//

import Foundation

protocol ModuleFactoryProtocol {
  func makeSplashNC() -> SplashNC
  func makeOnboardingVC() -> OnboardingVC
  func makeLoginVC() -> LoginVC
  func makeSignupVC(loginData: LoginHistoryData) -> SignupVC
  func makeBaseVC() -> BaseVC
  func makeHomeVC() -> HomeVC
  func makeFeedDetailVC(idx: Int) -> FeedDetailVC
  func makeFeedListVC(isMyPage: Bool) -> FeedListVC
  func makeMyPageVC() -> MyPageVC
  func makeSearchVC() -> SearchVC
  func makeSettingVC() -> SettingVC
  func makeWriteVC(bookInfo: WriteModel) -> WriteVC
  func makeFeedReportVC(isMyPage: Bool, nickname: String, feedId: String) -> FeedReportVC
}

final class ModuleFactory: ModuleFactoryProtocol{
  static let shared = ModuleFactory()
  private init() { }
  
  func makeSplashNC() -> SplashNC {
    let splashNC = SplashNC.controllerFromStoryboard(.splash)
    return splashNC
  }
  
  func makeOnboardingVC() -> OnboardingVC {
    let onboardingVC = OnboardingVC.controllerFromStoryboard(.onboarding)
    return onboardingVC
  }
  
  func makeLoginVC() -> LoginVC {
    let repository = DefaultLoginRepository(service: BaseService.default)
    let useCase = DefaultLoginUseCase(repository: repository)
    let viewModel = LoginViewModel(useCase: useCase)
    let loginVC = LoginVC.controllerFromStoryboard(.login)
    loginVC.viewModel = viewModel
    return loginVC
  }
  
  func makeSignupVC(loginData: LoginHistoryData) -> SignupVC {
    let repository = DefaultSignupRepository(service: BaseService.default)
    let useCase = DefaultSignupUseCase(repository: repository)
    let viewModel = SignupViewModel(useCase: useCase)
    let signupVC = SignupVC.controllerFromStoryboard(.signup)
    signupVC.viewModel = viewModel
    signupVC.loginData = loginData
    return signupVC
  }
  
  func makeSearchVC() -> SearchVC {
    let repository = DefaultSearchRepository(service: BaseService.default)
    let useCase = DefaultSearchUseCase(repository: repository)
    let viewModel = SearchViewModel(useCase: useCase)
    let searchVC = SearchVC.controllerFromStoryboard(.search)
    searchVC.viewModel = viewModel
    
    return searchVC
  }
  
  func makeWriteVC(bookInfo: WriteModel) -> WriteVC {
    let useCase = DefaultWriteUseCase()
    let viewModel = WriteViewModel(useCase: useCase, bookInfo: bookInfo)
    let writeVC = WriteVC.controllerFromStoryboard(.write)
    writeVC.viewModel = viewModel
    
    return writeVC
  }
  
  func  makeWriteCheckVC(writeInfo: WriteCheckModel) -> WriteCheckVC {
    let repository = DefaultWriteCheckRepository(service: BaseService.default)
    let useCase = DefaultWriteCheckUseCase(repository: repository)
    let viewModel = WriteCheckViewModel(useCase: useCase, data: writeInfo)
    let writeCheckVC = WriteCheckVC.controllerFromStoryboard(.writeCheck)
    writeCheckVC.viewModel = viewModel
    
    return writeCheckVC
  }
  
  func makeWriteCompleteVC() -> WriteCompleteVC {
    let useCase = DefaultWriteCompleteUseCase()
    let viewModel = WriteCompleteViewModel(useCase: useCase)
    let writeCompleteVC = WriteCompleteVC.controllerFromStoryboard(.writeComplete)
    writeCompleteVC.viewModel = viewModel
    
    return writeCompleteVC
  }
  
  func makeAlertVC() -> AlertVC {
    let alertVC = AlertVC.controllerFromStoryboard(.alert)
    
    return alertVC
  }
  
  func makeBaseVC() -> BaseVC { BaseVC.controllerFromStoryboard(.base) }
  func makeHomeVC() -> HomeVC { HomeVC.controllerFromStoryboard(.home) }
  func makeFeedDetailVC(idx: Int) -> FeedDetailVC {
    let repository = DefaultFeedRepository(service: BaseService.default)
    let useCase = DefaultFeedDetailUseCase(repository: repository)
    let viewModel = FeedDetailViewModel(useCase: useCase, idx: idx)
    let feedDetailVC =  FeedDetailVC.controllerFromStoryboard(.feedDetail)
    feedDetailVC.viewModel = viewModel
    return feedDetailVC
    }
  
  func makeFeedListVC(isMyPage: Bool) -> FeedListVC {
    let feedRepository = DefaultFeedListRepository(service: BaseService.default)
    let myPageRepository = DefaultMyPageRepository(service: BaseService.default)
    let useCase = DefaultFeedListUseCase(
      feedrepository: feedRepository)
    let viewModel = FeedListViewModel(useCase: useCase,
                                      isMyPage: isMyPage)
    let feedListVC =  FeedListVC.controllerFromStoryboard(.feedList)
    feedListVC.viewModel = viewModel
    feedListVC.isMyPage = isMyPage
    return feedListVC
  }
  
  func makeFilterVC(category: [Category]) -> FilterVC {
    let repository = DefaultFilterRepository(service: BaseService.default)
    let useCase = DefaultFilterUseCase(repository: repository)
    let viewModel = FilterViewModel(useCase: useCase)
    let filterVC = FilterVC.controllerFromStoryboard(.filter)
    filterVC.viewModel = viewModel
    filterVC.selectedCategory = category
    return filterVC
  }
  
  func makeFeedReportVC(isMyPage: Bool, nickname: String, feedId: String) -> FeedReportVC {
    let repository = DefaultFeedReportRepository()
    let useCase = DefaultFeedReportUseCase(repository: repository)
    let viewModel = FeedReportViewModel(useCase: useCase, isMyPage: isMyPage, userNickName: nickname, feedId: feedId)
    let feedReportVC = FeedReportVC.controllerFromStoryboard(.feedReport)
    feedReportVC.viewModel = viewModel
    return feedReportVC
  }
  
  func makeMyPageVC() -> MyPageVC { MyPageVC.controllerFromStoryboard(.mypage) }
  func makeSettingVC() -> SettingVC { SettingVC.controllerFromStoryboard(.setting) }

}
