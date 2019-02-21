//
//  RGGithubAppTests.swift
//  RGGithubAppTests
//
//  Created by Rafael on 19/02/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import XCTest
@testable import RGGithubApp

class RGGithubAppTests: XCTestCase {
  
  let service = try! GithubService(baseURL: "https://api.github.com")

  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testRequestRepos() {
    self.measure {
      service.fetchRepos() { githubResult in
        guard let githubResult = githubResult else {
          XCTAssertTrue(false, "githubResult retornou null.")
          return
        }
        guard let _ = githubResult.items else {
          XCTAssertTrue(false, "Não retornou itens. Talvez tenha chegado no limite de request por minuto.")
          return
        }
        XCTAssertTrue(true)
      }
    }
  }

}
