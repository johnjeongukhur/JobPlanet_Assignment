//
//  ViewController.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/16.
//

/*
 Storyboard - Main

 */

import UIKit

let menuCollectionViewHeight = 62.0
var searchTopInset = 0.0 // 상단의 Search 바 크기

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

class MainVC: UIViewController, RecruitChildDelegate {

    let viewModel = MainVM()
    
    @IBOutlet weak var searchLogoImage: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchBarBottomLine: UIView!
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    let menuItems: [Menu] = [.recruit, .company]
    var selectedMenu = Menu.recruit
    
    @IBOutlet weak var recuitView: UIView!
    @IBOutlet weak var companyView: UIView!
    
    /*
     searchSuperView - menuCollectionView의 상단에 위치하는 뷰 menuCollectionView 감춤
     recruitViewTopInset - 스크롤 올릴때 jobCollectionViewTop 영역 올림
     */
    @IBOutlet weak var searchSuperView: UIView!
    @IBOutlet weak var recruitViewTopInset: NSLayoutConstraint!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecruitChild" {
            DispatchQueue.main.async {
                let recruitVC = segue.destination as! RecruitChildVC
                recruitVC.height = self.searchSuperView.frame.height
                recruitVC.delegate = self
            }
        } else if segue.identifier == "toCompanyChild" {
            let recruitVC = segue.destination as! CompanyChildVC
            
        }
    }
    
    // 스크롤될때 menuCollection 숨기기위한 delegate 처리
    func didReceiveData(data: Double, isScroll: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.menuCollectionView.frame.origin.y = data
            if isScroll {
                self.recruitViewTopInset.constant = -62
            } else {
                self.recruitViewTopInset.constant = 0
            }
            self.view.layoutIfNeeded()

        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTopInset = searchSuperView.frame.height
        
        setupUI()
        
        searchSuperView.layer.zPosition = 0
        menuCollectionView.layer.zPosition = -1
    }
    
    func setupUI() {
        setupSearchBar()
        setupMenuView()
        
        companyView.isHidden = true
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
            textFieldInsideSearchBar.font = UIFont(name: JobPlanetFont.Regular.font, size: 17) ?? UIFont.systemFont(ofSize: 17)
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
}

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == menuCollectionView {
            return menuItems.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == menuCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: indexPath) as! MenuViewCell
            cell.configure(with: menuItems[indexPath.item].text, index: indexPath.row)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCollectionView {
            let selectedCell = collectionView.cellForItem(at: indexPath) as? MenuViewCell
            
            selectedMenu = Menu(rawValue: indexPath.item) ?? .recruit
            
            if indexPath.item == 0 {
                recuitView.isHidden = false
                companyView.isHidden = true
            } else {
                recuitView.isHidden = true
                companyView.isHidden = false
            }
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
        return CGSize(width: 50, height: 50)
    }
    
    
}

