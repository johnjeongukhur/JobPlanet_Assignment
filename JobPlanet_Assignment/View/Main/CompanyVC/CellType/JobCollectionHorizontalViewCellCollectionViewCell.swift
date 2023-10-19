//
//  JobCollectionHorizontalViewCellCollectionViewCell.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/19.
//

/*
하단의 Cell에서 collectionViewCell이 쓰임
 CellTypeRecruitCollectionTableViewCell
 */

import UIKit

class JobCollectionHorizontalViewCellCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    
    @IBOutlet weak var companyStackView: UIStackView!
    @IBOutlet weak var appealStackView: UIStackView!
    
    @IBOutlet weak var secondStackScrollView: UIScrollView!
    
    @IBOutlet weak var rewardLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ item: RecruitItem) {
        setupUI()
        
        if let imageURL = item.imageURL, let url = URL(string: imageURL) {
            imageView.kf.setImage(with: url)
        }
        titleLabel.text = item.title ?? ""
        
        ratingLabel.text = "\(item.company?.average ?? "0.0")"
        companyNameLabel.text = item.company?.name ?? ""
        
        rewardLabel.text = "축하금: \(item.reward?.wonSeparator() ?? "")원"
        
        // 기존 뷰 제거 후 다시 그림
        appealStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // 스택에 들어가는 text
        if let items = item.appealArray?.prefix(2) {
            for item in items {
                if !(item.isEmpty) {
                    let label = PaddingLabel()
                    label.text = item
                    label.font = UIFont(name: JobPlanetFont.Regular.font, size: 12)
                    label.textColor = JobplanetColor.Gray02.color
                    label.layer.borderWidth = 1.0
                    label.layer.borderColor = JobplanetColor.Gray03.color.cgColor
                    label.layer.cornerRadius = 5.0

                    label.edgeInset = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
                    
                    appealStackView.addArrangedSubview(label)
                }
            }
        }
    }
    
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    
    func setupUI() {
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleToFill
        
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 55) / 2
        imageViewWidth.constant = cellWidth

        
        titleLabel.font = UIFont(name: JobPlanetFont.Bold.font, size: 15)
        titleLabel.textColor = JobplanetColor.Gray01.color // 텍스트 색상 설정

        ratingLabel.font = UIFont(name: JobPlanetFont.Bold.font, size: 14)
        ratingLabel.textColor = JobplanetColor.Gray01.color

        
        companyNameLabel.font = UIFont(name: JobPlanetFont.Regular.font, size: 13) // 폰트 설정
        companyNameLabel.textColor = JobplanetColor.Gray01.color // 텍스트 색상 설정

        rewardLabel.font = UIFont(name: JobPlanetFont.Regular.font, size: 13) // 폰트 설정
        rewardLabel.textColor = JobplanetColor.Gray01.color // 텍스트 색상 설정
    }
}
