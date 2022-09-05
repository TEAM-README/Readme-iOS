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
  case getNickname
  case getSearchRecent
  case getSearch(query: String, display: Int, start: Int, sort: String)
  case write(bookCategory: String, quote: String, impression: String, book: BookModel)
  case deleteFeed(idx: Int)
  case postFeedReport(idx: Int)
}

extension BaseAPI: TargetType {
  public var baseURL: URL {
    var base = Config.Network.baseURL
    let search = Config.Network.searchURL
    
    switch self{
      case .postSignin,.postSignup,.getDuplicatedNicknameState,.getMyFeedList:
        base += "user"
    case .getFeedDetail,.getFeedList:
      base += "feed"
    case .getSearchRecent:
      base += "feed/recent"
    case .getNickname:
      base += ""
      case .deleteUser:
        base += "user"
    case .write:
      base += "feed"
    case .getSearch:
      guard let url = URL(string: search) else {
        fatalError("searchURL could not be configured")
      }
      return url

    default:
        base += ""

    }
    guard let url = URL(string: base) else {
      fatalError("baseURL could not be configured")
    }
    return url
  }
  
  // MARK: - Path
  var path: String {
    switch self{
      case .postSignin:
        return "/login"
      case .postSignup:
        return "/signup"
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
          .postFeedReport,
          .write:
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
    case .postSignin(let provider,let token):
      params["platform"] = provider
      params["socialToken"] = token
    case .getDuplicatedNicknameState(let nickname):
      params["nickname"] = nickname
    case .write(let bookcategory, let quote, let impression, let book):
      let bookParams: [String: Any] = [
        "isbn": book.isbn,
        "subIsbn": book.subIsbn,
        "title": book.title,
        "author": book.author,
        "image": book.image
      ]
      params["categoryName"] = bookcategory
      params["sentence"] = quote
      params["feeling"] = impression
      params["book"] = bookParams
    case .getSearch(let query, let display, let start, let sort):
      params["query"] = query
      params["display"] = display
      params["start"] = start
      params["sort"] = sort
    case .postSignup(let platform, let socialToken, let nickname):
      params["platform"] = platform
      params["socialToken"] = socialToken
      params["nickname"] = nickname
        
      case .getFeedList(let filter):
        params["filters"] = filter

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
      case .getSearch,.getDuplicatedNicknameState,.getFeedList:
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
      case .postSignin, .write,.postSignup,.getDuplicatedNicknameState,.getFeedList:
      return .requestParameters(parameters: bodyParameters ?? [:], encoding: parameterEncoding)
    case .getSearch:
      return .requestParameters(parameters: bodyParameters ?? [:], encoding: NaverParameterEncoding.init())
    default:
      return .requestPlain
      
    }
  }
  
  public var headers: [String: String]? {
    switch self {
    case .getSearch:
      return ["Content-Type": "application/json",
              "X-Naver-Client-Id": "ZGdnUsGMFrU8gPCdGxyi",
              "X-Naver-Client-Secret": "oyvfoKifc8"]
    default:
      // TODO: - 임시 토큰
        if let userToken = UserDefaults.standard.string(forKey:UserDefaultKeyList.Auth.accessToken) {
        return ["Authorization": userToken,
                "Content-Type": "application/json"]
      } else {
        return ["Content-Type": "application/json"]
      }

    }
  }
  
  public var validationType: ValidationType {
    return .successCodes
  }
  
  typealias Response = Codable
}


struct NaverParameterEncoding: ParameterEncoding {
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
      var newString = ""
      if var urlString = urlRequest.url?.absoluteString,
         let query = parameters?.queryParameters{
        urlString.removeLast()
        newString = urlString
        newString += "?"
        newString += query
      }
      
      urlRequest.url = URL(string: newString)
    
        return urlRequest
    }
}
