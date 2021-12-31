//
//  MainViewController.swift
//  GitHubApp
//
//  Created by 장기화 on 2021/12/31.
//

import UIKit

class MainViewController: UITableViewController {
    
    let organization = "Apple"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = organization + " Repository"
        tableView.register(MainListCell.self, forCellReuseIdentifier: "MainListCell")
        tableView.rowHeight = 140
        tableView.separatorStyle = .none
        
        setUpRefreshControl()
    }
    
    func setUpRefreshControl() {
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.backgroundColor = .white
        refreshControl.tintColor = .darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc func refresh() {
        
    }
}

extension MainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainListCell", for: indexPath) as? MainListCell else {
            return UITableViewCell() }
        cell.setUp()
        return cell
    }
}
