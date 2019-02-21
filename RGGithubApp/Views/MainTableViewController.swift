//
//  MainTableViewController.swift
//  RGGithubApp
//
//  Created by Rafael on 20/02/19.
//  Copyright © 2019 Rafael. All rights reserved.
//

import UIKit
import EasyPeasy

class MainTableViewController: UITableViewController {
  
  var buzy = UIActivityIndicatorView()
  
  var repositories = [RepositoreRemote]()
  let service:GithubService? = {
    return try? GithubService()
  }()
  
  var maxItems = NSNotFound
  var isLoad = false

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.buzySetup()
    self.refreshControlSetup()
    self.loadItems()
  }
  
  //MARK: Setup
  
  func buzySetup() {
    self.tableView.addSubview(buzy)
    buzy.color = UIColor.black
    buzy.hidesWhenStopped = true
  }
  
  func refreshControlSetup() {
    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }
  
  //MARK: Alert errors
  
  func showServiceError() {
    showErrorWithMessage("Serviço não localizado.")
  }
  
  func showErrorWithMessage(_ message:String) {
    AlertHelper.showMessage(message, withTitle: "Ops...", inController: self, withAction: nil)
  }
  
  // MARK: Update values
  
  @objc private func refreshData(_ sender: Any) {
    loadItems()
  }
  
  func loadItems() {
    if (maxItems != NSNotFound && (isLoad || maxItems <= repositories.count)) {
      return
    }
    guard let service = self.service else {
      self.showServiceError()
      return
    }
    let currentPage:Int = (repositories.count / kPerPageItems) + 1
    isLoad = true
    buzy.startAnimating()
    
    service.fetchRepos(currentPage: currentPage) { [weak self] githubResult in
      self?.isLoad = false
      self?.buzy.stopAnimating()
      self?.refreshControl?.endRefreshing()
      
      guard let githubResult = githubResult else {
        self?.showErrorWithMessage("Tente novamente mais tarde.")
        return
      }
      guard let items = githubResult.items else {
        self?.showErrorWithMessage(githubResult.message ?? "Server error")
        return
      }
      self?.maxItems = githubResult.totalCount ?? NSNotFound
      self?.addItems(items)
      self?.tableView.reloadData()
    }
  }
  
  func addItems(_ items:[RepositoreRemote]) {
    self.repositories = self.repositories + items
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return repositories.count
    }
    return 0
  }
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    if (maxItems <= repositories.count) {
      return nil
    }
    return buzy
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "repoID", for: indexPath) as! RepositoreTableViewCell
    cell.repo = repositories[indexPath.row]
    if (indexPath.row == repositories.count-1) {
      loadItems()
    }
    return cell
  }

}
