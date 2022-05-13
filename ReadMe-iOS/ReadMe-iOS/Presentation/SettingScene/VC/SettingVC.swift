//
//  SettingVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/21.
//

import UIKit

class SettingVC: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var backButton: UIButton!
  
  @IBOutlet weak var contactLabel: UILabel!
  @IBOutlet weak var agreementLabel: UILabel!
  @IBOutlet weak var logoutLabel: UILabel!
  
  @IBOutlet weak var contactButton: UIButton!
  @IBOutlet weak var agreementButton: UIButton!
  @IBOutlet weak var logoutButton: UIButton!
  
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

    [contactLabel,agreementLabel,logoutLabel].forEach { label in
      label?.font = .readMeFont(size: 15, type: .medium)
    }
    contactLabel.text = I18N.Setting.contact
    contactLabel.textColor = .grey04
    
    agreementLabel.text = I18N.Setting.agreement
    agreementLabel.textColor = .grey04
    
    logoutLabel.text = ""
    logoutLabel.textColor = .logoutRed
  }
  
  private func setButtonActions() {
    contactButton.press {
      self.openExternalLink(url: "https://flaxen-warlock-70e.notion.site/8dd759bd71d94caf82f52f177428060d")
    }
    
    agreementButton.press {
      self.openExternalLink(url: "https://flaxen-warlock-70e.notion.site/c66b80b220814a94a699d83def211904")
    }
    
    logoutButton.press {
//      self.postObserverAction(.logout)
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
