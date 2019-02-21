//
//  AlertHelper.swift
//  RGGithubApp
//
//  Created by Rafael on 20/02/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit

class AlertHelper: NSObject {
  
  static func showMessage(_ message:String, withTitle:String, inController:UIViewController, withAction:((UIAlertAction) -> ())? ) {
    let alert = UIAlertController(title: withTitle, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: withAction))
    
    inController.present(alert, animated: true, completion: nil)
  }

}
