//
//  CompanyChildVC.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/18.
//

import UIKit

class CompanyChildVC: UIViewController {
    
    let viewModel = MainVM()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getCellItems {
            self.tableView.reloadData()
        }
        
        setupUI()
    }
    
    func setupUI() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
}

extension CompanyChildVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.cellItems.value?.cellItems?.count ?? 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MARK: "cell_type"에 따라 각각의 다른 디자인 셀이 호출 됨
        if let item = viewModel.cellItems.value?.cellItems {
            let data = item[indexPath.item]
            if data.cellType == "CELL_TYPE_COMPANY" {
                let customCell = CellTypeCompanyTableViewCell.loadFromNib()
                customCell.configure(data)
                return customCell
            }
            else if data.cellType == "CELL_TYPE_HORIZONTAL_THEME" {
                let customCell = CellTypeRecruitCollectionTableViewCell.loadFromNib()
                
                if let list = item[indexPath.item].recommendRecruit {
                    customCell.sectionTitleLabel.text = item[indexPath.item].sectionTitle ?? ""
                    customCell.dataList = list
                    customCell.collectionView.reloadData()
                }
                return customCell
            }
            else if data.cellType == "CELL_TYPE_REVIEW" {
                let customCell = CellTypeReviewTableViewCell.loadFromNib()
                
                customCell.configure(data)
                return customCell
            }
            
            
        }
        return UITableViewCell()

        
    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300 // 셀의 높이를 50 포인트로 지정
//    }

    
}

//extension CompanyChildVC: UICollectionViewDataSource, UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//         if collectionView == cellTypeCollectionView {
//            return viewModel.recruitItem.value?.recruitItems?.count ?? 0
//        }
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//         if collectionView == cellTypeCollectionView {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JobCell", for: indexPath) as! JobViewCell
//
//            if let item = viewModel.recruitItem.value?.recruitItems?[indexPath.row] {
//                cell.configure(item)
//            }
//
//            return cell
//        }
//        return UICollectionViewCell()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == cellTypeCollectionView {
//            let selectedOption = indexPath.item
//        }
//    }
//}
