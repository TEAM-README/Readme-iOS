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
}

final class ModuleFactory: ModuleFactoryProtocol{
  static let shared = ModuleFactory()
  private init() { }
  
  func makeLoginVC() -> LoginVC { LoginVC.controllerFromStoryboard(.login) }
  func makeBaseVC() -> BaseVC { BaseVC.controllerFromStoryboard(.base) }
  func makeHomeVC() -> HomeVC { HomeVC.controllerFromStoryboard(.home) }
  func makeMyPageVC() -> MyPageVC { MyPageVC.controllerFromStoryboard(.mypage) }

}
