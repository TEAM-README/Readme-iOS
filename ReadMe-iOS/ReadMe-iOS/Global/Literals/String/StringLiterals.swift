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
    static let total = "총 "
    static let countDescription = "의 글이 있어요"
  }
  
  struct Setting {
    static let settingTitle = "환경설정"
    static let contact = "문의하기"
    static let agreement = "약관 보기"
    static let logout = "로그아웃"
  }
  
  struct Write {
    static let startCheer = " 님의 시작을 응원해요!"
    static let heartCheer = " 님의 마음을 응원해요!"
    static let startDescribe = "기록은 독서의 시작입니다. 책을 끝까지 읽지 못했더라도 읽는 도중 인상 깊었던 문장을 적어보세요."
    static let heartDescribe = "글을 눈으로 읽어내려가는 것에만 그친다면 진정한 독서라고 할 수 없죠. 인상 깊었던 문장에 대한 느낀점도 남겨볼까요?"
    static let categoryTitle = "책의 카테고리를 선택해주세요"
    static let quoteTitle = "인상 깊었던 문장을 적어주세요"
    static let quotePlaceholder = "어떤 문장이 인상 깊었나요?"
    static let impressionTitle = "느낀점을 적어주세요"
    static let impressionPlaceholder = "책을 읽었을 때 무엇을 느끼고 배우셨나요?"
    static let selectedBook = "내가 선택한 책"
    static let interestedSentence = "에서 인상 깊었던 문장"
  }
  
  struct WriteCheck {
    static let titleThrough = "기록을 통해 "
    static let titleDay = " 님의 하루가\n 더 풍요로워졌길 바라요!"
  }
  
  struct WriteComplete {
    static let title = "등록을 완료했어요"
    static let subtitle = "피드 와 마이페이지 에서\n작성한 감상글을 확인할 수 있어요"
    static let move = "피드 구경하러 가기"
  }
  
  struct Filter {
    
  }
  
  struct Button {
    static let next = "다음"
    static let register = "등록하기"
    static let reset = " 필터 초기화"
    static let apply = "적용"
    static let report = "신고하기"
    static let delete = "삭제하기"
  }
  
  struct ReadmeAlert {
    static let title = "기록한 내용을 버리고\n돌아가시겠습니까?"
    static let description = "작성한 내용이 저장되지 않습니다"
    static let cancel = "취소"
    static let ok = "확인"
  }
}
