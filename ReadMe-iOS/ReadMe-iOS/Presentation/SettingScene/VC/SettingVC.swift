//
//  SettingVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/21.
//

import UIKit
import MessageUI

class SettingVC: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var backButton: UIButton!
  
  @IBOutlet weak var contactLabel: UILabel!
  @IBOutlet weak var agreementLabel: UILabel!
  @IBOutlet weak var logoutLabel: UILabel!
  
  @IBOutlet weak var contactButton: UIButton!
  @IBOutlet weak var agreementButton: UIButton!
  @IBOutlet weak var logoutButton: UIButton!
  
  @IBOutlet weak var withdrawButton: UIButton!
  @IBOutlet weak var withdrawLabel: UILabel!
  @IBOutlet weak var settingHeaderTopConstraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureUI()
    self.setButtonActions()
  }
  
}

extension SettingVC {
  private func configureUI() {
    settingHeaderTopConstraint.constant = calculateTopInset()
    titleLabel.textColor = .grey05
    titleLabel.font = .readMeFont(size: 16, type: .semiBold)
    titleLabel.text = I18N.Setting.settingTitle

    [contactLabel,agreementLabel,logoutLabel,withdrawLabel].forEach { label in
      label?.font = .readMeFont(size: 15, type: .medium)
    }
    contactLabel.text = I18N.Setting.contact
    contactLabel.textColor = .grey04
    
    agreementLabel.text = I18N.Setting.agreement
    agreementLabel.textColor = .grey04
    
    logoutLabel.text = I18N.Setting.logout
    logoutLabel.textColor = .logoutRed
    
    withdrawLabel.text = I18N.Setting.withdraw
    withdrawLabel.textColor = .logoutRed
  }
  
  private func setButtonActions() {
    contactButton.press {
      self.sendContact()
    }
    
    agreementButton.press {
      self.openExternalLink(url: "https://paint-red-74c.notion.site/e187f3913b914e869cf48c9bf10fc751")
    }
    
    logoutButton.press {
      self.makeAlert(title: "알림", message: "로그아웃을 하시겠습니까?",cancelButtonNeeded: true) { _ in
        UserDefaults.standard.setValue(true, forKey: UserDefaultKeyList.Onboarding.onboardingComplete)
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        self.postObserverAction(.moveLoginVC)
      }

    }
    
    withdrawButton.press {
      self.makeAlert(title: "경고", message: "회원 탈퇴를 하시겠습니까?",cancelButtonNeeded: true) { _ in
        BaseService.default.deleteUserWithdraw { result in
          result.success { state in
            print("state")
            let defaults = UserDefaults.standard
            let dictionary = defaults.dictionaryRepresentation()
            dictionary.keys.forEach { key in
                defaults.removeObject(forKey: key)
            }
            self.postObserverAction(.moveLoginVC)
            
          }.catch { err in
            print("err")
          }
        }
      }
    }
    
    backButton.press {
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  private func openExternalLink(url: String) {
    guard let url = URL(string: url) else {return}
    UIApplication.shared.open(url, options: [:])
  }
}

extension SettingVC {
  private func sendContact() {
      if MFMailComposeViewController.canSendMail() {
      let mailComposeVC = MFMailComposeViewController()
      mailComposeVC.mailComposeDelegate = self
      mailComposeVC.setToRecipients(["Readme.team.sopterm@gmail.com"])
      mailComposeVC.setSubject("리드미 문의하기")
      self.present(mailComposeVC, animated: true, completion: nil)
    } else {
      let mailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
      let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in }
      mailErrorAlert.addAction(confirmAction)
      self.present(mailErrorAlert, animated: true, completion: nil)
    }
  }
}

extension SettingVC: MFMailComposeViewControllerDelegate {
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      switch result {
      case .cancelled:
          controller.dismiss(animated: true) { self.makeAlert(message: "신고가 취소되었습니다.") }
      case .sent:
          controller.dismiss(animated: true) {  self.makeAlert(message: "신고가 접수되었습니다.") }
      case .failed:
          controller.dismiss(animated: true) { self.makeAlert(message: "네트워크 상태를 확인해주세요.")}
      default:
          return
      }
  }
}
