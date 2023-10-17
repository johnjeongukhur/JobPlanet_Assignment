//
//  JobPlanetAPI.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/16.
//

import Foundation
import Alamofire
import RxSwift

enum JobPlanetAPI {
    static let baseURL = URL(string: "https://jpassets.jobplanet.co.kr/mobile-config/")!
    
    static func headers() -> HTTPHeaders {
        return [
            "Authorization": "",
            "Content-Language": "ko",
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
    }
}

extension JobPlanetAPI {
    static private func makeRequest<T: Decodable>(_ url: URL, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> Observable<T> {
        return Observable.create { observer in
            let request = AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    
    static func get<T: Decodable>(_ url: URL) -> Observable<T> {
        return makeRequest(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: JobPlanetAPI.headers())
    }
    
}

extension JobPlanetAPI {
    static let recuitItems = "test_data_recruit_items.json"
    static let cellItems = "test_data_cell_items.json"
    
    static func getRecuitItems() -> Observable<RecruitListModel> {
        return get(baseURL.appendingPathComponent(recuitItems))
    }
    
    static func getCellItems() -> Observable<[CellItemsModel]> {
        return get(baseURL.appendingPathComponent(cellItems))
    }
}
