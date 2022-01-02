//
//  Repository.swift
//  GitHubApp
//
//  Created by 장기화 on 2021/12/31.
//

import Foundation

struct Repository: Codable {
    let id: Int
    let name: String
    let description: String
    let starCount: Int
    let language: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, language
        case starCount = "stargazers_count"
    }
}
