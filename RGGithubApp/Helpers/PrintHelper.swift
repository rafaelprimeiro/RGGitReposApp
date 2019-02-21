//
//  PrintHelper.swift
//  RGGithubApp
//
//  Created by Rafael on 20/02/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit

class PrintHelper: NSObject {
  static let shared = PrintHelper()
  
  func log(obj:Any, message:String?) {
    #if debug
    if let message = message {
      print(message)
    }
    debugPrint(obj)
    #endif
  }
}
