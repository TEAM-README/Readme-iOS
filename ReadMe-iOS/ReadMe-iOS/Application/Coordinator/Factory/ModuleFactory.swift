//
//  ModuleFactory.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/30.
//

import Foundation

protocol ModuleFactoryProtocol {
  func makeLoginVC() -> LoginVC
  func makeSignupVC() -> SignupVC
  func makeBaseVC() -> BaseVC
  func makeHomeVC() -> HomeVC
  func makeFeedDetailVC(idx: Int) -> FeedDetailVC
  func makeFeedListVC() -> FeedListVC
  func makeMyPageVC() -> MyPageVC
  func makeSearchVC() -> SearchVC
  func makeWriteVC() -> WriteVC
}

final class ModuleFactory: ModuleFactoryProtocol{
  static let shared = ModuleFactory()
  private init() { }
  
  func makeLoginVC() -> LoginVC {
    let repository = DefaultLoginRepository(service: BaseService.default)
    let useCase = DefaultLoginUseCase(repository: repository)
    let viewModel = LoginViewModel(useCase: useCase)
    let loginVC = LoginVC.controllerFromStoryboard(.login)
    loginVC.viewModel = viewModel
    return loginVC
  }
  
  func makeSignupVC() -> SignupVC {
    let repository = DefaultSignupRepository(service: BaseService.default)
    let useCase = DefaultSignupUseCase(repository: repository)
    let viewModel = SignupViewModel(useCase: useCase)
    let loginVC = SignupVC.controllerFromStoryboard(.signup)
    loginVC.viewModel = viewModel
    return loginVC
  }
  
  func makeSearchVC() -> SearchVC {
    let repository = DefaultSearchRepository(service: BaseService.default)
    let useCase = DefaultSearchUseCase(repository: repository)
    let viewModel = SearchViewModel(useCase: useCase)
    let searchVC = SearchVC.controllerFromStoryboard(.search)
    searchVC.viewModel = viewModel
    
    return searchVC
  }
  
  func makeWriteVC() -> WriteVC {
    let useCase = DefaultWriteUseCase()
    let viewModel = WriteViewModel(useCase: useCase)
    let writeVC = WriteVC.controllerFromStoryboard(.write)
    writeVC.viewModel = viewModel
    
    return writeVC
  }
  
  func  makeWriteCheckVC() -> WriteCheckVC {
    let repository = DefaultWriteCheckRepository(service: BaseService.default)
    let useCase = DefaultWriteCheckUseCase(repository: repository)
    let viewModel = WriteCheckViewModel(useCase: useCase)
    let writeCheckVC = WriteCheckVC.controllerFromStoryboard(.writeCheck)
    writeCheckVC.viewModel = viewModel
    
    return writeCheckVC
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
  
  func makeFeedListVC() -> FeedListVC {
    let repository = DefaultFeedListRepository(service: BaseService.default)
    let useCase = DefaultFeedListUseCase(repository: repository)
    let viewModel = FeedListViewModel(useCase: useCase)
    let feedListVC =  FeedListVC.controllerFromStoryboard(.feedList)
    feedListVC.viewModel = viewModel
    return feedListVC
  }
  
  func makeMyPageVC() -> MyPageVC { MyPageVC.controllerFromStoryboard(.mypage)
  }
}
