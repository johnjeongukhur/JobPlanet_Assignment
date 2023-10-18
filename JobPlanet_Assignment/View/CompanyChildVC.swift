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
        tableView.register(CompanyTableViewCell.self, forCellReuseIdentifier: "CompanyTableViewCell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! CompanyTableViewCell
        
        if let item = viewModel.cellItems.value?.cellItems {
            cell.configure(item[indexPath.item])
        }
        return cell
    }

    
    
}
