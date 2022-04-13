//
//  LoginVC + Apple.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/14.
//

import UIKit
import AuthenticationServices

extension LoginVC {
  func appleLoginAuthRequest() {
    let appleIDProvider = ASAuthorizationAppleIDProvider()
    let request = appleIDProvider.createRequest()
    request.requestedScopes = [.fullName, .email]
    
    let authorizationController = ASAuthorizationController(authorizationRequests: [request])
    authorizationController.delegate = self
    authorizationController.presentationContextProvider = self
    authorizationController.performRequests()
  }

}

extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return self.view.window!
  }
}

extension LoginVC: ASAuthorizationControllerDelegate {
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    switch authorization.credential {
      case let appleIDCredential as ASAuthorizationAppleIDCredential:
        guard let identityToken = appleIDCredential.identityToken,
              let tokenString = String(data: identityToken, encoding: .utf8) else {
          self.loginRequestFail.onNext(.apple)
          break
        }
        print("🍎 Apple Login 성공",tokenString)
        let authRequestModel = LoginRequestModel(platform: .apple, platformAccessToken: tokenString)
        self.loginRequest.onNext(authRequestModel)
      default:
        break
    }
  }
  
  // Apple ID 연동 실패 시
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    self.loginRequestFail.onNext(.apple)
  }
}
