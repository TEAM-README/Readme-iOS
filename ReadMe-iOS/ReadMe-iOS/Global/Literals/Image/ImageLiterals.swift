//
//  ImageLiterals.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/03.
//

import UIKit

struct ImageLiterals{
  
  struct TabBar{
    static let addButton = UIImage(named: "add_btn")!
    
    static let home = UIImage(named: "tab-home")!
    static let homeSelected = UIImage(named: "tab-home-clicked")!
    
    static let mypage = UIImage(named: "tab-mypage")!
    static let mypageSelected = UIImage(named: "tab-mypage-clicked")!
  }
  
  struct Onboarding {
    static let onboardingImg1 = UIImage(named: "img_onboarding1")!
    static let onboardingImg2 = UIImage(named: "img_onboarding2")!
    static let onboardingImg3 = UIImage(named: "img_onboarding3")!
    
    static let dotImg1 = UIImage(named: "dots_1")!
    static let dotImg2 = UIImage(named: "dots_2")!
    static let dotImg3 = UIImage(named: "dots_3")!
  }
  
  struct Search {
    static let search = UIImage(named: "ic_ search")
  }
  
  struct WriteCheck {
    static let bg = UIImage(named: "writeCheck_bg")
  }
  struct WriteComplete {
    static let check = UIImage(named: "ic_ check")
  }
  
  struct ReadmeAlert {
    static let alert = UIImage(named: "ic_ alert")
  }
  
  struct Filter {
    static let reset = UIImage(named: "ic_reset")
  }
}
