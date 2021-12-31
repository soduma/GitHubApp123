//
//  MainListCell.swift
//  GitHubApp
//
//  Created by 장기화 on 2021/12/31.
//

import UIKit
import SnapKit

class MainListCell: UITableViewCell {
    var repository: String?
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let starImageView = UIImageView()
    let starLabel = UILabel()
    let languageLabel = UILabel()
}

extension MainListCell {
    func setUp() {
        [nameLabel, descriptionLabel, starImageView, starLabel, languageLabel]
            .forEach { addSubview($0) }
        
        nameLabel.text = "ㅎㅇㅎㅇ"
        nameLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
