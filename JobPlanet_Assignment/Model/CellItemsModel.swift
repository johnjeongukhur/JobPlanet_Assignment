//
//  CellItemsModel.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/16.
//

import Foundation

struct CellItemsModel: Codable {
    let cellItems: [CellItem]?

    enum CodingKeys: String, CodingKey {
        case cellItems = "cell_items"
    }
}

struct CellItem: Codable {
    let cellType: String?
    let logoPath: String?
    let name, industryName: String?
    let rateTotalAvg: Double?
    let reviewSummary: String?
    let salaryAvg: Int?
    let updateDate, interviewQuestion: String?
    let count: Int?
    let sectionTitle: String?
    let recommendRecruit: [RecruitItem]?

    enum CodingKeys: String, CodingKey {
        case cellType = "cell_type"
        case logoPath = "logo_path"
        case name
        case industryName = "industry_name"
        case rateTotalAvg = "rate_total_avg"
        case reviewSummary = "review_summary"
        case salaryAvg = "salary_avg"
        case updateDate = "update_date"
        case interviewQuestion = "interview_question"
        case count
        case sectionTitle = "section_title"
        case recommendRecruit = "recommend_recruit"
    }
}
