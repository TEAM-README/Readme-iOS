//
//  BaseAPI.swift
//  ReadMe-iOS
//
//  Created by 송지훈 on 2022/04/03.
//

import Moya
import Alamofire

enum BaseAPI{
  // Auth
  case postSignup(platform: String,socialToken: String,nickname: String)
  case postSignin(platform: String,socialToken: String)
  case postSampleSignin
  case getDuplicatedNicknameState(nickname: String)
  case deleteUser
  
  // Feed List
  case getMyFeedList
  case getFeedList(filter: String)
  case getFeedDetail(idx: Int)
  case deleteFeed(idx: Int)
  case postFeedReport(idx: Int)
  
  // Feed Write
  case getSearchRecent
  //FIXME: - Parameter 가 너무 많아서 DTO 모델로 나중에 바꿀 예정
  case postFeed(categoryName: String,sentence: String, feeling: String, isbn: Int, subIsbn: Int,
                title: String, author: String, image: String)
  
}

extension BaseAPI: TargetType {
  public var baseURL: URL {
    var base = Config.Network.baseURL
    switch self{
      case .postSignup,.postSignin,.postSampleSignin,.getDuplicatedNicknameState,
          .deleteUser,.getMyFeedList:
        base += "/user"
        
      case .getFeedList,.getFeedDetail,.deleteFeed,.getSearchRecent,.postFeed:
        base += "/feed"
        
      case .postFeedReport:
        base += "/report"
    }
    guard let url = URL(string: base) else {
      fatalError("baseURL could not be configured")
    }
    return url
  }
  
  // MARK: - Path
  var path: String {
    switch self{
      case .postSignup:
        return "/signup"
      case .postSignin:
        return "/login"
      case .postSampleSignin:
        return "/auth/access-token"
      case .getDuplicatedNicknameState:
        return "/nickname"
      case .getMyFeedList:
        return "/myFeeds"
      case .getFeedDetail(let idx),.deleteFeed(let idx),.postFeedReport(let idx):
        return "/\(idx)"
      default :
        return ""
    }
  }
  
  // MARK: - Method
  var method: Moya.Method {
    switch self{
      case .postSignin,
          .postSignup,
          .postSampleSignin,
          .postFeedReport:
        return .post
      case .deleteUser,
          .deleteFeed:
        return .delete
      default :
        return .get
        
    }
  }
  
  // MARK: - Data
  var sampleData: Data {
    return Data()
  }
  
  // MARK: - Parameters
  /// - note :
  ///  post를 할때, body Parameter를 담아서 전송해야하는 경우가 있는데,
  ///  이 경우에 사용하는 부분입니다.
  ///
  ///  (get에서는 사용 ❌, get의 경우에는 쿼리로)
  ///
  private var bodyParameters: Parameters? {
    var params: Parameters = [:]
    switch self{
      case .postSignup(let platform, let socialToken, let nickname):
        params["platform"] = platform
        params["socialToken"] = socialToken
        params["nickname"] = nickname
        
      case .postSignin(let platform, let socialToken):
        params["platform"] = platform
        params["socialToken"] = socialToken
        
      case .postSampleSignin:
        params["nickname"] = "리드미"
      
      case .getFeedList(let filter):
        params["filters"] = filter
        
      case .getDuplicatedNicknameState(let nickname):
        params["query"] = nickname
        
      case .postFeed(let categoryName,let sentence,let feeling,
                     let isbn,let subIsbn,let title,let author,
                     let image):
        params["categoryName"] = categoryName
        params["sentence"] = sentence
        params["feeling"] = feeling
        params["isbn"] = isbn
        params["subIsbn"] = subIsbn
        params["title"] = title
        params["author"] = author
        params["image"] = image

      default:
        break
    }
    return params
  }
  
  /// - note :
  ///  query문을 사용하는 경우 URLEncoding 을 사용해야 합니다
  ///  나머지는 그냥 전부 다 default 처리.
  ///
  private var parameterEncoding : ParameterEncoding{
    switch self {
      case .getFeedList:
        return URLEncoding.init(destination: .queryString, arrayEncoding: .noBrackets, boolEncoding: .literal)
      default :
        return JSONEncoding.default
        
    }
  }
  
  /// - note :
  ///  body Parameters가 있는 경우 requestParameters  case 처리.
  ///  일반적인 처리는 모두 requestPlain으로 사용.
  ///
  var task: Task {
    switch self{
      case .postSignup,.postSignin,.postSampleSignin,
          .getDuplicatedNicknameState,.getFeedList,.postFeed:
        return .requestParameters(parameters: bodyParameters ?? [:], encoding: parameterEncoding)
      default:
        return .requestPlain
        
    }
  }
  
  public var headers: [String: String]? {
    
    if let userToken = UserDefaults.standard.string(forKey: "authorization") {
      return ["authorization": userToken,
              "Content-Type": "application/json"]
    } else {
      return ["Content-Type": "application/json"]
    }
  }
  
  public var validationType: ValidationType {
    return .successCodes
  }
  
  typealias Response = Codable
}
