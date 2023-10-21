//
//  StringExtension.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/18.
//

import Foundation

// 날짜 포맷 변경
extension String {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy.MM.dd"
            return dateFormatter.string(from: date)
        }
        
        return self
    }
}
