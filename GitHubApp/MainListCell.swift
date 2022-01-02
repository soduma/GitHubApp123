//
//  MainListCell.swift
//  GitHubApp
//
//  Created by 장기화 on 2021/12/31.
//

import UIKit
import SnapKit

class MainListCell: UITableViewCell {
    var repository: Repository?
    
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
        
        guard let repository = repository else { return }
//        nameLabel.text = "gdgdg"
        nameLabel.text = repository.name
        nameLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
//        descriptionLabel.text = "Gegd"
        descriptionLabel.text = repository.description
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.numberOfLines = 2
        
        starImageView.image = UIImage(systemName: "star")
        starImageView.tintColor = .systemYellow
        starImageView.contentMode = .scaleAspectFill
        
//        starLabel.text = "123123"
        starLabel.text = ("\(repository.starCount)")
        starLabel.font = .systemFont(ofSize: 16)
        starLabel.textColor = .systemGray
        
//        languageLabel.text = "Gdgadga"
        languageLabel.text = repository.language
        languageLabel.font = .systemFont(ofSize: 16)
        languageLabel.textColor = .systemGray
        
        nameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(18)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(nameLabel)
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.width.height.equalTo(20)
            $0.bottom.equalToSuperview().inset(18)
        }
        
        starLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView)
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
        }
        
        languageLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView)
            $0.leading.equalTo(starLabel.snp.trailing).offset(10)
        }
    }
}
