//
//  RecruitModel.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/16.
//

import Foundation

struct RecruitListModel: Codable {
    let recruitItems: [RecruitItem]?

    enum CodingKeys: String, CodingKey {
        case recruitItems = "recruit_items"
    }
}

struct RecruitItem: Codable {
    let id: Int?
    let title: String?
    let reward: Int?
    let appeal: String?
    let imageURL: String?
    let company: Company?

    enum CodingKeys: String, CodingKey {
        case id, title, reward, appeal
        case imageURL = "image_url"
        case company
    }
    
    var appealArray: [String]? {
        return appeal?.components(separatedBy: ", ")
    }
}

struct Company: Codable {
    let name: String?
    let logoPath: String?
    let ratings: [Rating]?

    enum CodingKeys: String, CodingKey {
        case name
        case logoPath = "logo_path"
        case ratings
    }
    
    var average: String {
        guard let ratings = ratings, !ratings.isEmpty else { return "0.0" }
        
        if let highestRating = ratings.max(by: { $0.rating ?? 0.0 < $1.rating ?? 0.0 })?.rating {
            return String(format: "%.1f", highestRating)
        } else {
            return "0.0"
        }
    }
}

struct Rating: Codable {
    let type: String?
    let rating: Double?
}
