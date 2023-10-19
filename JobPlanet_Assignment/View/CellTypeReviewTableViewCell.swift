//
//  CellTypeReviewTableViewCell.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/19.
//

import UIKit

class CellTypeReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var tableSeparator: UIView!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyRatingLabel: UILabel!
    @IBOutlet weak var companyCategoryLabel: UILabel!
    @IBOutlet weak var companyBottomLine: UIView!
    
    @IBOutlet weak var reviewSummaryLabel: UILabel! // 리뷰
    @IBOutlet weak var updateDateLabel: UILabel! // 업데이트 날짜
    @IBOutlet weak var prosLabel: UILabel! // 평균 연봉
    @IBOutlet weak var prosContentLabel: UILabel! // 평균 연봉 가격
    @IBOutlet weak var consLabel: UILabel! // 만원
    @IBOutlet weak var consContentLabel: UILabel! // 만원
    
    static func loadFromNib() -> CellTypeReviewTableViewCell {
        let nib = UINib(nibName: "CellTypeReviewTableViewCell", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as! CellTypeReviewTableViewCell
        return cell
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ data: CellItem) {
        if let imageURL = data.logoPath, let url = URL(string: imageURL) {
            logoImageView.kf.setImage(with: url)
        }
        companyNameLabel.text = data.name ?? ""
        companyRatingLabel.text = "\(data.rateTotalAvg ?? 0.0)"
        companyCategoryLabel.text = data.industryName ?? ""
        
        reviewSummaryLabel.text = data.reviewSummary ?? ""
        updateDateLabel.text = data.updateDate?.formatDate() ?? ""
        
        prosContentLabel.text = data.pros ?? ""
        consContentLabel.text = data.cons ?? ""
    
        
        setupCompanyIntro()
        setupCompanyReview()
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
        prosContentLabel.setLineSpacing(spacing: 4)
        consContentLabel.setLineSpacing(spacing: 4)
        
        reviewSummaryLabel.font = UIFont(name: JobPlanetFont.SemiBold.font, size: 18)
        reviewSummaryLabel.textColor = JobplanetColor.Gray01.color

        updateDateLabel.font = UIFont(name: JobPlanetFont.Regular.font, size: 13)
        updateDateLabel.textColor = JobplanetColor.Gray01.color

//        salaryAvgLabel.font = UIFont(name: JobPlanetFont.Medium.font, size: 17)
//        salaryAvgLabel.textColor = JobplanetColor.Green.color
//
//        salaryAvgPriceLabel.font = UIFont(name: JobPlanetFont.Bold.font, size: 24)
//        salaryAvgPriceLabel.textColor = JobplanetColor.Gray01.color
//
//        salaryAvgWonLabel.font = UIFont(name: JobPlanetFont.Medium.font, size: 17)
//        salaryAvgWonLabel.textColor = JobplanetColor.Gray01.color

        prosLabel.font = UIFont(name: JobPlanetFont.Bold.font, size: 17)
        prosLabel.textColor = JobplanetColor.Blue.color

        prosContentLabel.font = UIFont(name: JobPlanetFont.Medium.font, size: 17)
        prosContentLabel.textColor = JobplanetColor.Gray01.color
        
        
        consLabel.font = UIFont(name: JobPlanetFont.Bold.font, size: 17)
        consLabel.textColor = JobplanetColor.Red.color

        consContentLabel.font = UIFont(name: JobPlanetFont.Medium.font, size: 17)
        consContentLabel.textColor = JobplanetColor.Gray01.color

    }
    

    
    
}
