//
//  ModuleFactory.swift
//  BeMyPlan
//
//  Created by 송지훈 on 2022/01/30.
//

import Foundation

protocol ModuleFactoryProtocol {
  func makeLoginVC() -> LoginVC
  func makeBaseVC() -> BaseVC
  func makeHomeVC() -> HomeVC
  func makeMyPageVC() -> MyPageVC
  func makeSearchVC() -> SearchVC
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
  
  func makeSearchVC() -> SearchVC {
    let repository = DefaultSearchRepository()
    let useCase = DefaultSearchUseCase(repository: repository)
    let viewModel = SearchViewModel(useCase: useCase)
    let searchVC = SearchVC.controllerFromStoryboard(.search)
    searchVC.viewModel = viewModel
    
    return searchVC
  }
  
  func makeBaseVC() -> BaseVC { BaseVC.controllerFromStoryboard(.base) }
  func makeHomeVC() -> HomeVC { HomeVC.controllerFromStoryboard(.home) }
  func makeMyPageVC() -> MyPageVC { MyPageVC.controllerFromStoryboard(.mypage) }

}
