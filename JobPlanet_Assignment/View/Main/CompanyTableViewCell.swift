//
//  CompanyTableViewCell.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/18.
//

import UIKit
import Kingfisher

class CompanyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableSeparator: UIView!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyRatingLabel: UILabel!
    @IBOutlet weak var companyCategoryLabel: UILabel!
    @IBOutlet weak var companyBottomLine: UIView!
    
    @IBOutlet weak var reviewSummaryLabel: UILabel! // 리뷰
    @IBOutlet weak var updateDateLabel: UILabel! // 업데이트 날짜
    @IBOutlet weak var salaryAvgLabel: UILabel! // 평균 연봉
    @IBOutlet weak var salaryAvgPriceLabel: UILabel! // 평균 연봉 가격
    @IBOutlet weak var salaryAvgWonLabel: UILabel! // 만원
    
    @IBOutlet weak var interviewQuestionLabel: UILabel! // "면접질문"
    @IBOutlet weak var interviewQuestionContentLabel: UILabel! // 후기
    
    @IBOutlet weak var sectionTitle: UILabel!
    
    
    func configure(_ data: CellItem) {
        if let imageURL = data.logoPath, let url = URL(string: imageURL) {
            logoImageView.kf.setImage(with: url)
        }
        companyNameLabel.text = data.name ?? ""
        companyRatingLabel.text = "\(data.rateTotalAvg ?? 0.0)"
        companyCategoryLabel.text = data.industryName ?? ""
        
        reviewSummaryLabel.text = data.reviewSummary ?? ""
        updateDateLabel.text = data.updateDate?.formatDate() ?? ""
        salaryAvgPriceLabel.text = "\(data.salaryAvg?.wonSeparator() ?? "0")"
        interviewQuestionContentLabel.text = data.interviewQuestion ?? ""
        
        sectionTitle.text = data.sectionTitle ?? ""
        
        setupCompanyIntro()
        setupCompanyReview()
        setupSectionView()
    }
    
    // 로고, 회사이름 etc
    func setupCompanyIntro() {
        tableSeparator.backgroundColor = JobplanetColor.Gray03.color
        
        logoImageView.layer.borderWidth = 1
        logoImageView.layer.borderColor = JobplanetColor.Gray03.color.cgColor
        logoImageView.layer.cornerRadius = 5
        
        companyNameLabel.font = UIFont(name: JobPlanetFont.Bold.font, size: 18)
        companyNameLabel.textColor = JobplanetColor.Gray01.color
        
        companyRatingLabel.font = UIFont(name: JobPlanetFont.Bold.font, size: 14)
        companyRatingLabel.textColor = JobplanetColor.Gray01.color

        companyCategoryLabel.font = UIFont(name: JobPlanetFont.Regular.font, size: 13)
        companyCategoryLabel.textColor = JobplanetColor.Gray01.color

        companyBottomLine.backgroundColor = JobplanetColor.Gray03.color
    }
    
    // 회사 리뷰, ex) "경력 대비 연봉..
    func setupCompanyReview() {
        reviewSummaryLabel.setLineSpacing(spacing: 4)
        interviewQuestionContentLabel.setLineSpacing(spacing: 4)
        
        reviewSummaryLabel.font = UIFont(name: JobPlanetFont.SemiBold.font, size: 18)
        reviewSummaryLabel.textColor = JobplanetColor.Gray01.color

        updateDateLabel.font = UIFont(name: JobPlanetFont.Regular.font, size: 13)
        updateDateLabel.textColor = JobplanetColor.Gray01.color

        salaryAvgLabel.font = UIFont(name: JobPlanetFont.Medium.font, size: 17)
        salaryAvgLabel.textColor = JobplanetColor.Green.color

        salaryAvgPriceLabel.font = UIFont(name: JobPlanetFont.Bold.font, size: 24)
        salaryAvgPriceLabel.textColor = JobplanetColor.Gray01.color

        salaryAvgWonLabel.font = UIFont(name: JobPlanetFont.Medium.font, size: 17)
        salaryAvgWonLabel.textColor = JobplanetColor.Gray01.color

        interviewQuestionLabel.font = UIFont(name: JobPlanetFont.Bold.font, size: 17)
        interviewQuestionLabel.textColor = JobplanetColor.Gray01.color

        interviewQuestionContentLabel.font = UIFont(name: JobPlanetFont.Medium.font, size: 17)
        interviewQuestionContentLabel.textColor = JobplanetColor.Gray01.color
    }
    
    func setupSectionView() {
        sectionTitle.font = UIFont(name: JobPlanetFont.Bold.font, size: 20)
        sectionTitle.textColor = JobplanetColor.Gray01.color
    }
    
}
