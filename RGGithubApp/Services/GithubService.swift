//
//  GithubService.swift
//  RGGithubApp
//
//  Created by Rafael on 19/02/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit
import Alamofire

//MARK: - CONSTANTS
let kPerPageItems = 50

class GithubService: BaseService {
  
  //MARK: - Fetchs
  
  func fetchRepos(currentPage:Int = 1, completion: @escaping (_ result: GithubResult?) -> ()) {
    
    // Add URL parameters
    let urlParams:[String : Any] = [
      "q":"language:swift",
      "sort":"stars",
      "per_page":"50",
      "page":currentPage,
    ]
    
    let path = "\(baseURL)/search/repositories"
    
    // Fetch Request
    self.request(path, parameters: urlParams, httpMethod: .get, encoding: URLEncoding.default) { remoteResultData in
      switch remoteResultData {
        case .success(let data):
          do {
            let remoteResult = try GithubResult(data: data)
            completion(remoteResult)
          } catch let error {
            PrintHelper.shared.log(obj: error, message: "json parse error")
            completion(nil)
          }
          break
        case .fail(let error):
          PrintHelper.shared.log(obj: error, message: "Server error")
          completion(nil)
          break
      }
    }
  }
}
