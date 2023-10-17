//
//  ViewController.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/16.
//

import UIKit

let menuCollectionViewHeight = 62.0

enum Menu: Int {
    case recruit
    case company
    
    var text: String {
        switch self {
        case .recruit: return "채용"
        case .company: return "기업"
        }
    }
    
}

class MainVC: UIViewController {

    let viewModel = MainVM()
    
    @IBOutlet weak var searchLogoImage: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarBottomLine: UIView!
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    let menuItems: [Menu] = [.recruit, .company]
    var selectedMenu = Menu.recruit
    
    
    @IBOutlet weak var jobCollectionView: UICollectionView!
    
    /*
     searchSuperView - menuCollectionView의 상단에 위치하는 뷰 menuCollectionView 감춤
     jobCollectionViewTop - 스크롤 올릴때 jobCollectionViewTop 영역 올림
     */
    @IBOutlet weak var searchSuperView: UIView!
    @IBOutlet weak var jobCollectionViewTop: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getRecruitList {
            self.jobCollectionView.reloadData()
        }
        
        setupUI()
    }
    
    func setupUI() {
        setupSearchBar()
        setupMenuView()
        setupJobView()
    }
    
    func setupSearchBar() {
        searchBar.barTintColor = .white
        searchBarBottomLine.backgroundColor = JobplanetColor.Green.color

        //SearchBar Default 위, 아래 줄 Separator 제거
        searchBar.backgroundImage = UIImage()
        // 돋보기 아이콘을 숨김
        searchBar.setImage(UIImage(), for: .search, state: .normal)

        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.textColor = .black
            textFieldInsideSearchBar.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 17) ?? UIFont.systemFont(ofSize: 17)
            textFieldInsideSearchBar.backgroundColor = .white
            textFieldInsideSearchBar.attributedPlaceholder = NSAttributedString(
                string: "기업, 채용공고 검색",
                attributes: [NSAttributedString.Key.foregroundColor: JobplanetColor.Gray02.color]
            )
        }

        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.textColor = .black
        }
    }
    
    func setupMenuView() {
        menuCollectionView.register(MenuViewCell.self, forCellWithReuseIdentifier: "MenuViewCell")
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        
        // 첫번째 메뉴 "채용" Default
        let indexPath = IndexPath(item: 0, section: 0)
        menuCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
    }

    func setupJobView() {
        jobCollectionView.register(JobViewCell.self, forCellWithReuseIdentifier: "JobViewCell")
        jobCollectionView.dataSource = self
        jobCollectionView.delegate = self
    }
    

}

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuCollectionView {
            return menuItems.count
        } else if collectionView == jobCollectionView {
            return viewModel.recruitList.value?.recruitItems?.count ?? 0
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == menuCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuViewCell
            cell.configure(with: menuItems[indexPath.item].text, index: indexPath.row)
            
            return cell
        } else if collectionView == jobCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JobCell", for: indexPath) as! JobViewCell
            
            if let item = viewModel.recruitList.value?.recruitItems?[indexPath.row] {
                cell.configure(item)
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCollectionView {
            let selectedCell = collectionView.cellForItem(at: indexPath) as? MenuViewCell
            
            selectedMenu = Menu(rawValue: indexPath.item) ?? .recruit

        } else if collectionView == jobCollectionView {
            let selectedOption = indexPath.item
        }
    }
}

extension MainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == menuCollectionView {
            return 8.0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == menuCollectionView {
            return 8.0
        }
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

extension MainVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == jobCollectionView {
            let yOffset = scrollView.contentOffset.y
            let topInset = searchBar.frame.height + searchBarBottomLine.frame.height + view.safeAreaInsets.top


            UIView.animate(withDuration: 0.3) {
                if yOffset > topInset {
                    // 스크롤 내렸을 떄
                    self.menuCollectionView.frame.origin.y = 0
                    self.menuCollectionView.layer.opacity = 0.0
                    self.jobCollectionViewTop.constant = -menuCollectionViewHeight
                    
                    self.view.sendSubviewToBack(self.menuCollectionView)
                    self.searchSuperView.sendSubviewToBack(self.menuCollectionView)
                    
                } else {
                    // 상단에 도착했을 때
                    self.jobCollectionViewTop.constant = 0
                    self.menuCollectionView.frame.origin.y = topInset
                    self.menuCollectionView.layer.opacity = 1.0
                }

                self.view.layoutIfNeeded()
            }
        }

    }
}
