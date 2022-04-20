//
//  StringLiterals.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/03.
//

import Foundation

struct I18N {
  
  struct Alert {
    static let error = "에러"
    static let networkError = "네트워크 오류가 발생하였습니다."
  }
  
  struct Component {
    static let startButton = "시작하기"
  }
  
  struct Tabbar {
    static let home = "Home"
    static let mypage = "My Page"
  }
  
  struct Login {
    static let guideText = "간단한 회원가입으로 리드미를 시작해볼까요?"
    static let guideEmphasisText = "간단한 회원가입"
    static let kakao = "카카오"
    static let apple = "애플"
    static let loginFailMessage = " 로그인에 실패하였습니다."
  }
  
  struct Signup {
    static let title = "닉네임을 알려주세요"
    static let subtitle = "설정된 닉네임은 수정이 불가합니다."
    static let textfieldPlacehodler = "특수문자는 사용할 수 없습니다"
    static let nicknameDuplicatedErr = "중복된 닉네임입니다."
    static let characterErr = "특수문자를 사용할 수 없습니다."
    static let byteExceedErr = "닉네임은 20자를 초과할 수 없습니다."
    static let availableNickname = "사용 가능한 닉네임입니다."
  }
  
  struct Search {
    static let textfieldPlaceholder = "책 제목을 검색하세요"
    static let recentRead = "최근에 읽었어요"
    static let emptyBeforeSearch = "책을 검색하고 읽은 책을 추가해보세요"
    static let emptyAfterSearch = "책 검색 결과가 없습니다"
  }
  
  struct FeedList {
    static let categoryNoSelect = "관심 있는 카테고리를"
    static let categoryNoSelectBold = "관심 있는 카테고리"
    static let categoryDescriptionNoselect = "선택해보세요"
    static let categoryDescription = "관심이 있어요"
  }
  
  struct MyPage {
    static let nicknameDescription = " 님의 책장"
    static let count = "개"
    static let total = "총"
    static let countDescription = "의 글이 있어요"
  }
}
