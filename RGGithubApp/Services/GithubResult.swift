//
//  GithubResult.swift
//  RGGithubApp
//
//  Created by Rafael on 19/02/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit

struct GithubResult: Codable {
  let totalCount: Int?
  let incompleteResults: Bool?
  let items: [RepositoreRemote]?
  let message: String?
  let documentationURL: String?
  
  enum CodingKeys: String, CodingKey {
    case totalCount = "total_count"
    case incompleteResults = "incomplete_results"
    case items
    case message
    case documentationURL = "documentation_url"
  }
}

struct RepositoreRemote: Codable {
  let name: String
  let owner: UserRemote
  let stargazersCount: Int
  
  enum CodingKeys: String, CodingKey {
    case name
    case owner
    case stargazersCount = "stargazers_count"
  }
}

struct UserRemote: Codable {
  let login: String
  let avatarURL: String
  
  enum CodingKeys: String, CodingKey {
    case login
    case avatarURL = "avatar_url"
    
  }
}

extension GithubResult {
  init(data: Data) throws {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    self = try decoder.decode(GithubResult.self, from: data)
  }
  
  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }
}
