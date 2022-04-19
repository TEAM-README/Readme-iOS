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
  func makeMyPageVC() -> MyPageVC
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
  func makeMyPageVC() -> MyPageVC { MyPageVC.controllerFromStoryboard(.mypage) }

}
