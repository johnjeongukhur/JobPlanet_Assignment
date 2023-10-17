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
    
    var recruitList = BehaviorRelay<RecruitListModel?>(value: nil)

    func getRecruitList(action: @escaping () -> Void) {
        JobPlanetAPI.getRecuitItems()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                switch event {
                case .next(let item):
                    self?.recruitList.accept(item)
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
