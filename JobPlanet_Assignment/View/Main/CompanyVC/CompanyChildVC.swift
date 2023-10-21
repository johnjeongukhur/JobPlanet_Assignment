//
//  CompanyChildVC.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/18.
//

/*
 MainVC의 자식뷰

 cell_type 세 가지로 분류됨, API에서 내려주는 cell_type에 따라 변경
 1. CompanyCell
 2. RecruitCollectionCell
 3. ReviewCell
 
 */

enum CellType {
    case Company
    case Recruit
    case Review
    
    var name: String {
        switch self {
        case .Company: return "CELL_TYPE_COMPANY"
        case .Recruit: return "CELL_TYPE_HORIZONTAL_THEME"
        case .Review: return "CELL_TYPE_REVIEW"
        }
    }
}

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
            if data.cellType == CellType.Company.name {
                let customCell = CellTypeCompanyTableViewCell.loadFromNib()
                customCell.configure(data)
                return customCell
            }
            else if data.cellType == CellType.Recruit.name {
                let customCell = CellTypeRecruitCollectionTableViewCell.loadFromNib()
                
                if let list = item[indexPath.item].recommendRecruit {
                    customCell.configure(item[indexPath.item].sectionTitle ?? "")
                    customCell.dataList = list
                    customCell.collectionView.reloadData()
                }
                return customCell
            }
            else if data.cellType == CellType.Review.name {
                let customCell = CellTypeReviewTableViewCell.loadFromNib()
                customCell.configure(data)
                return customCell
            }
        }
        return UITableViewCell()
    }
}

