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
  let documentationUrl: String?
}

struct RepositoreRemote: Codable {
  let name: String
  let owner: UserRemote
  let stargazersCount: Int
}

struct UserRemote: Codable {
  let login: String
  let avatarUrl: String
}

extension GithubResult {
  init(data: Data) throws {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    self = try decoder.decode(GithubResult.self, from: data)
  }
  
  init(_ json: String, using encoding: String.Encoding = .utf8) throws {
    guard let data = json.data(using: encoding) else {
      throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
    }
    try self.init(data: data)
  }
}
