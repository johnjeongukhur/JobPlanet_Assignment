//
//  WonSeparator.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/16.
//

import Foundation

extension Int {
    func wonSeparator() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
