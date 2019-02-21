//
//  RepositoreTableViewCell.swift
//  RGGithubApp
//
//  Created by Rafael on 20/02/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit

class RepositoreTableViewCell: UITableViewCell {

  @IBOutlet weak var imgUser: UIImageView!
  @IBOutlet weak var lblRepoName: UILabel!
  @IBOutlet weak var lblOwnerName: UILabel!
  @IBOutlet weak var lblStars: UILabel!
  
  var repo:RepositoreRemote? = nil {
    didSet {
      guard let repo = repo else { return }
      lblRepoName.text = repo.name
      lblOwnerName.text = repo.owner.login
      lblStars.text = "\(repo.stargazersCount)"
      imgUser.loadImageWithUrl(string: repo.owner.avatarURL)
    }
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
