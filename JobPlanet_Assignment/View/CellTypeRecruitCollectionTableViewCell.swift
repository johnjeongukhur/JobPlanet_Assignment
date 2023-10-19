//
//  CellTypeRecruitCollectionTableViewCell.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/19.
//

import UIKit

class CellTypeRecruitCollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sectionTitleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataList: [RecruitItem]?
    
    static func loadFromNib() -> CellTypeRecruitCollectionTableViewCell {
        let nib = UINib(nibName: "CellTypeRecruitCollectionTableViewCell", bundle: nil)
        let cell = nib.instantiate(withOwner: self, options: nil).first as! CellTypeRecruitCollectionTableViewCell
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "JobCollectionHorizontalViewCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CellTypeRecruitCollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! JobCollectionHorizontalViewCellCollectionViewCell
        
        if let item = dataList?[indexPath.item] {
            cell.configure(item)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedItem = yourDataSourceArray[indexPath.item]
        print("\(indexPath.item)")
    }
}

extension CellTypeRecruitCollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
    
