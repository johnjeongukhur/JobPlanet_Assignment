//
//  RecruitChildVC.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/18.
//

/*
 
 */

import UIKit

protocol RecruitChildDelegate: AnyObject {
    func didReceiveData(data: Double, isScroll: Bool)
}

class RecruitChildVC: UIViewController {
    
    let viewModel = MainVM()
    
    weak var delegate: RecruitChildDelegate?
    
    var height = 0.0
    
    @IBOutlet weak var jobCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getRecruitItem {
            self.jobCollectionView.reloadData()
        }

        setupUI()
    }
    
    
    func setupUI() {
        setupJobView()
    }
    
    func setupJobView() {
        jobCollectionView.register(JobViewCell.self, forCellWithReuseIdentifier: "JobViewCell")
        jobCollectionView.dataSource = self
        jobCollectionView.delegate = self
    }
}


extension RecruitChildVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if collectionView == jobCollectionView {
            return viewModel.recruitItem.value?.recruitItems?.count ?? 0
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if collectionView == jobCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JobCell", for: indexPath) as! JobViewCell
            
            if let item = viewModel.recruitItem.value?.recruitItems?[indexPath.row] {
                cell.configure(item)
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == jobCollectionView {
            let selectedOption = indexPath.item
        }
    }
}

extension RecruitChildVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == jobCollectionView {
            let screenWidth = UIScreen.main.bounds.size.width
            let cellWidth = (screenWidth - 55) / 2
            let cellHeight: CGFloat = cellWidth * 1.4
            return CGSize(width: cellWidth, height: cellHeight)
        } else {
            return CGSize(width: 50, height: 50)
        }
    }
    
    
}

extension RecruitChildVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == jobCollectionView {
            let yOffset = scrollView.contentOffset.y
            let topInset = searchTopInset
            
            if yOffset > topInset {
                // 스크롤 내렸을 떄
                self.delegate?.didReceiveData(data: 0, isScroll: true)
            } else {
                // 상단에 도착했을 때
                self.delegate?.didReceiveData(data: height, isScroll: false)
            }
        }
    }
}
