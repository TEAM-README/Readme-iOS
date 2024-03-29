//
//  OnboardingVC.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/05/10.
//

import UIKit
import Then

final class OnboardingVC: UIViewController {

  // MARK: - Vars & Lets Part
  private var pageIndex = 0{ didSet { setPageControlImage() }}
  private let factory: ModuleFactoryProtocol = ModuleFactory.shared

  // MARK: - UI Component Part

  lazy var mainContentView = UIView()
  lazy var contentScrollInnerView = UIView()
  lazy var bottomPageControlView = UIView()
  lazy var nextActionButton = UIButton().then {
    $0.isExclusiveTouch = true
  }

  lazy var skipActionButton = UIButton().then {
    $0.isExclusiveTouch = true
  }

  lazy var imageStackView = UIStackView().then {
    $0.distribution = .fillEqually
    $0.spacing = 0
    $0.axis = .horizontal
  }
  lazy var contentScrollView = UIScrollView().then {
    $0.isPagingEnabled = true
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
    $0.isExclusiveTouch = true
    $0.bounces = false
    $0.delegate = self
  }

  lazy var headerFirstLabel = UILabel().then {
    $0.setTextWithLineHeight(text: I18N.Onboarding.headerFirst,
                             lineHeightMultiple: 1.15)
    $0.font = .readMeFont(size: screenWidth*24/390, type: .bold)
    $0.numberOfLines = 0
    $0.textColor = .black
    $0.textAlignment = .center
    $0.alpha = 1
  }

  lazy var headerSecondLabel = UILabel().then {
    $0.setTextWithLineHeight(text: I18N.Onboarding.headerSecond,
                             lineHeightMultiple: 1.15)
    $0.font = .readMeFont(size: screenWidth*24/390, type: .bold)
    $0.numberOfLines = 0
    $0.textColor = .black
    $0.textAlignment = .center
    $0.alpha = 0
  }

  lazy var headerThirdLabel = UILabel().then {
    $0.setTextWithLineHeight(text: I18N.Onboarding.headerThird,
                             lineHeightMultiple: 1.15)
    $0.font = .readMeFont(size: screenWidth*24/390, type: .bold)
    $0.numberOfLines = 0
    $0.textColor = .black
    $0.textAlignment = .center
    $0.alpha = 0
  }
  
  lazy var descriptionFirstLabel = UILabel().then {
    $0.setTextWithLineHeight(text: I18N.Onboarding.descriptionFirst,
                             lineHeightMultiple: 1.25)
    $0.font = .readMeFont(size: screenWidth*15/390, type: .light)
    $0.numberOfLines = 0
    $0.textColor = .grey04
    $0.textAlignment = .center
    $0.alpha = 1
  }
  
  lazy var descriptionSecondLabel = UILabel().then {
    $0.setTextWithLineHeight(text: I18N.Onboarding.descriptionSecond,
                             lineHeightMultiple: 1.25)
    $0.font = .readMeFont(size: screenWidth*15/390, type: .light)
    $0.numberOfLines = 0
    $0.textColor = .grey04
    $0.textAlignment = .center
    $0.alpha = 0
  }
  
  lazy var descriptionThirdLabel = UILabel().then {
    $0.setTextWithLineHeight(text: I18N.Onboarding.descriptionThird,
                             lineHeightMultiple: 1.25)
    $0.font = .readMeFont(size: screenWidth*15/390, type: .light)
    $0.numberOfLines = 0
    $0.textColor = .grey04
    $0.textAlignment = .center
    $0.alpha = 0
  }

  lazy var contentFirstImageView = UIImageView().then {
    $0.image = ImageLiterals.Onboarding.onboardingImg1
    $0.contentMode = .scaleAspectFit
  }

  lazy var contentSecondImageView = UIImageView().then {
    $0.image = ImageLiterals.Onboarding.onboardingImg2
    $0.contentMode = .scaleAspectFit
  }

  lazy var contentThirdImageView = UIImageView().then {
    $0.image = ImageLiterals.Onboarding.onboardingImg3
    $0.contentMode = .scaleAspectFit
  }

  lazy var nextButtonLabel = UILabel().then {
    $0.font = .boldSystemFont(ofSize: 16)
    $0.textColor = .mainBlue
    $0.text = I18N.Onboarding.next
    $0.textAlignment = .center
  }

  lazy var skipButtonLabel = UILabel().then {
    $0.font = .boldSystemFont(ofSize: 16)
    $0.textColor = .grey02
    $0.text = I18N.Onboarding.skip
    $0.textAlignment = .center
  }

  lazy var pageControlImageView = UIImageView().then {
    $0.image = ImageLiterals.Onboarding.dotImg1
  }

  // MARK: - Life Cycle Part

  override func viewDidLoad() {
    super.viewDidLoad()
    AppLog.log(at: FirebaseAnalyticsProvider.self, .onboardingFirstOpen)
    self.configureUI()
    self.configureImageScrollView()
    self.configureMainContentView()
    self.configureBottomPageControlView()
//    self.configureImageShadow()
    self.setButtonActions()

  }

}
// MARK: - Extension Part
private extension OnboardingVC {
  func setButtonActions() {
    nextActionButton.press {
      if self.pageIndex != 2{
        self.pageIndex += 1
        self.contentScrollView.setContentOffset(CGPoint(x: CGFloat(self.pageIndex) * screenWidth, y: 0),
                                                animated: true)
      }else {
        self.pushLoginVC()
        UserDefaults.standard.setValue(true, forKey: UserDefaultKeyList.Onboarding.onboardingComplete)
      }
    }
    skipActionButton.press {
      self.pushLoginVC()
      UserDefaults.standard.setValue(true, forKey: UserDefaultKeyList.Onboarding.onboardingComplete)
    }
  }

  func setPageControlImage(){
    switch(pageIndex) {
      case 0:
        nextButtonLabel.text = I18N.Onboarding.next
        pageControlImageView.image = ImageLiterals.Onboarding.dotImg1

      case 1:
        nextButtonLabel.text = I18N.Onboarding.next
        pageControlImageView.image = ImageLiterals.Onboarding.dotImg2

      default:
        nextButtonLabel.text = I18N.Onboarding.start
        pageControlImageView.image = ImageLiterals.Onboarding.dotImg3
    }
  }

  private func pushLoginVC(){
    let loginVC = factory.makeLoginVC()
    navigationController?.pushViewController(loginVC, animated: true)
  }
  
  private func pushBaseView() {
    let baseVC = ModuleFactory.shared.makeBaseVC()
    navigationController?.pushViewController(baseVC, animated: false)
  }
}

extension OnboardingVC: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let pointX = scrollView.contentOffset.x
    switch(pointX){
      case 0 ... screenWidth/2 :
        headerFirstLabel.alpha = (screenWidth/2 - pointX) / (screenWidth/2)
        headerSecondLabel.alpha = 0
        headerThirdLabel.alpha = 0
        
        descriptionFirstLabel.alpha = (screenWidth/2 - pointX) / (screenWidth/2)
        descriptionSecondLabel.alpha = 0
        descriptionThirdLabel.alpha = 0

      case screenWidth/2 ... screenWidth * 2/2 :
        headerFirstLabel.alpha = 0
        headerSecondLabel.alpha = (pointX - screenWidth/2) / (screenWidth/2)
        headerThirdLabel.alpha = 0
        
        descriptionFirstLabel.alpha = 0
        descriptionSecondLabel.alpha = (pointX - screenWidth/2) / (screenWidth/2)
        descriptionThirdLabel.alpha = 0

      case screenWidth * 2/2 ... screenWidth * 3/2 :
        headerFirstLabel.alpha = 0
        headerSecondLabel.alpha = (screenWidth * 3/2 - pointX) / (screenWidth/2)
        headerThirdLabel.alpha = 0
        
        descriptionFirstLabel.alpha = 0
        descriptionSecondLabel.alpha = (screenWidth * 3/2 - pointX) / (screenWidth/2)
        descriptionThirdLabel.alpha = 0

      case screenWidth * 3/2 ... screenWidth * 4/2 :
        headerFirstLabel.alpha = 0
        headerSecondLabel.alpha = 0
        headerThirdLabel.alpha = (pointX - screenWidth * 3/2) / (screenWidth / 2)
        
        descriptionFirstLabel.alpha = 0
        descriptionSecondLabel.alpha = 0
        descriptionThirdLabel.alpha = (pointX - screenWidth * 3/2) / (screenWidth / 2)

      default :
        headerFirstLabel.alpha = 0
        headerSecondLabel.alpha = 0
        headerThirdLabel.alpha = 0
        
        descriptionFirstLabel.alpha = 0
        descriptionSecondLabel.alpha = 0
        descriptionThirdLabel.alpha = 0
    }

  }

  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    pageIndex = Int(targetContentOffset.pointee.x/screenWidth)
  }
}
