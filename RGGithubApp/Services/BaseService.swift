//
//  BaseService.swift
//  RGGithubApp
//
//  Created by Rafael on 19/02/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit
import Alamofire

//MARK: - CONSTANT

fileprivate let kBASE_URL_KEY = "END_POINT"

//MARK - ENUM

enum RemoteResult<Value> {
  /// - failure: Returns an NSError.
  case fail(Error)
  /// - success: Returns a value specified on implementation.
  case success(Value)
}

//MARK: - BaseService

class BaseService: NSObject {
  
  //MARK: Fields
  
  let baseURL:String
  
  //MARK: Initialises
  
  init(baseURL:String? = nil) throws {
    if let baseURL = baseURL {
      self.baseURL = baseURL
    } else {
      if let baseURLInfo = Bundle.main.object(forInfoDictionaryKey: kBASE_URL_KEY) as? String {
        self.baseURL = baseURLInfo
      } else {
        throw NSError.init(domain: "Base url not found", code: 1, userInfo: nil)
      }
    }
  }
  
  //MARK: Sessions
  
  static let networkSession: Alamofire.SessionManager = {
    let sessionConfiguration = URLSessionConfiguration.default
    sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData
    
    let instanceNetworkSession = Alamofire.SessionManager(configuration: sessionConfiguration)
    
    return instanceNetworkSession
  }()
  
  //MARK: Requests
  
  func request(_ pathURL:String, parameters: [String:Any], httpMethod: Alamofire.HTTPMethod, encoding:ParameterEncoding, completion: @escaping (_ result: RemoteResult<Data>) -> ()) {
    
    let dataRequest = BaseService.networkSession.request(pathURL, method: httpMethod, parameters: parameters, encoding: encoding, headers: nil)
    
    dataRequest.validate()
    
    dataRequest.responseJSON { responseObject in
      if (responseObject.result.error == nil) {
        completion(RemoteResult.success(responseObject.data!))
      } else {
        completion(RemoteResult.fail(responseObject.result.error!))
      }
    }
  }
  
}
