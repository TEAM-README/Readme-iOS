//
//  FeedDetailRepository.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/16.
//

import RxSwift

protocol FeedRepository {
  func getBookDetailInformation(idx: Int) -> Observable<FeedDetailEntity?>
}

final class DefaultFeedRepository {
  
  private let networkService: FeedServiceType
  private let disposeBag = DisposeBag()

  init(service: FeedServiceType) {
    self.networkService = service
  }
}

extension DefaultFeedRepository: FeedRepository {
  func getBookDetailInformation(idx: Int) -> Observable<FeedDetailEntity?> {
//    return networkService.getBookDetailInformation(idx: idx)
    return makeMockFeedEntity()
  }
}

extension DefaultFeedRepository {
  private func makeMockFeedEntity() -> Observable<FeedDetailEntity?> {
    return .create { observer in
      let fakeFeedInformation = FeedDetailEntity.init(imgURL: "https://bookthumb-phinf.pstatic.net/cover/071/526/07152669.jpg?udate=20220203",
                                                      category: "경제/경영",
                                                      title: "총균쇠",
                                                      author: "재레드 다이아몬드",
                                                    sentence: "스페인이 잉카를 정복할 수 있었던 원인은 그들이 유전적으로 더 우월해서가 절대 아니다.",
                                                      comment: "유럽의 여러 국가는 제국시대에 아프리카와 아메리카 대륙의 많은 나라를 식민지로 만들었다. 그들이 손쉽게 피지배국의 인류를 살상하거나 굴복시킬 수 있었던 직접적인 이유는 바로 이 책의 제목인 총, 균, 쇠를 유독 유럽의 국가만이 독점적으로 가지고 있었기 때문이다. 여기서 총, 균, 쇠는 실제로 두 대륙 간의 현격한 힘의 격차를 만들어낸 대표적인 3가지의 요소임과 동시에 원인이 되는 또 다른 요소들을 대표하는 말이기도 하다. 총, 균, 쇠라는 말은 강력한 군대, 전염병에 대한 저항력, 압도적인 기술력을 상징하는 1차적인 의미임과 동시에 2차적으로 그런 세 요소가 특정 집단에 편중될 수밖에 없었던 주요한 원동력을 내포하는 말이다.\n\n\n해당 3가지 요소의 유별난 발전을 만들어낸 원동력은 실로 다양하고 깊다. 가령 강력한 군대는 기술력을 바탕으로 한 강력한 무기와 방어구 및 인간에게 길들여진 말의 존재 등 물리적인 요소로 인해 강함의 칭호를 부여받기도 하지만 그 이면에는 복잡한 정치 사회 조직과 종교가 만들어낸 군인 집단의 통일된 정신상태도 존재한다. 중앙집권적 국가는 꾸준한 애국심 고취를 통해 전쟁에서 개인보다 집단의 이익을 생각하는 병사의 정신상태를 만들어낼 수 있었으며 종교는 민족과 민족을 믿는 자와 믿지 않는 자로 구별하여 살육에 대해 각 병사들이 도덕적 갈등을 겪지 않아도 될 만큼 충분히 타당성 있는 기저 인식을 제공했다. 또한 문자의 유무는 양질의 정보를 얼마나 정확히 전달할 수 있는지를 결정하여 첩보전의 수준 차이, 전술 기획의 밀도 차이를 만들어냈다.",
                                                      nickname: "혜화동쌍가마",
                                                      date: "2020/12/31")
      observer.onNext(fakeFeedInformation)
      return Disposables.create()
    }
  }
}
