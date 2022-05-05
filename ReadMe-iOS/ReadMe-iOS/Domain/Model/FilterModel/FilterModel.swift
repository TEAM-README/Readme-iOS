//
//  FilterModel.swift
//  ReadMe-iOS
//
//  Created by 양수빈 on 2022/05/02.
//

import Foundation

struct FilterModel {
  let category: Category
}

enum Category: String, CaseIterable {
  case novel = "소설"
  case essay = "시/에세이"
  case human = "인문"
  case health = "건강"
  case social = "사회"
  case hobby = "취미/레저"
  case history = "역사/문화"
  case religion = "종교"
  case home = "가정/생활/요리"
  case language = "국어/외국어"
  case travel = "여행/지도"
  case computer = "컴퓨터/IT"
  case magazine = "잡지"
  case comic = "만화"
  case art = "예술/대중문화"
  case improve = "자기계발"
  case economy = "경제/경영"
}
