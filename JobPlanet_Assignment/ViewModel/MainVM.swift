//
//  MainVM.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/16.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class MainVM {
    
    let disposeBag = DisposeBag()
    
    var recruitItem = BehaviorRelay<RecruitListModel?>(value: nil)
    
    var cellItems = BehaviorRelay<CellItemsModel?>(value: nil)

    func getRecruitItem(action: @escaping () -> Void) {
        JobPlanetAPI.getRecuitItems()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                switch event {
                case .next(let item):
                    self?.recruitItem.accept(item)
                    action()
                case .error(let error):
                    print("Error: \(error.localizedDescription)")
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
    func getCellItems(action: @escaping () -> Void) {
        JobPlanetAPI.getCellItems()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                switch event {
                case .next(let item):
                    self?.cellItems.accept(item)
                    action()
                case .error(let error):
                    print("Error: \(error.localizedDescription)")
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
}
