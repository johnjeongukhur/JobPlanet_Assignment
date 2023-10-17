//
//  MenuCell.swift
//  JobPlanet_Assignment
//
//  Created by John Hur on 2023/10/16.
//

import Foundation
import UIKit

class MenuViewCell: UICollectionViewCell {
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var textBackgroundView: UIView!
    
    
    func configure(with text: String) {
        menuLabel.text = text
        
        menuLabel.textColor = .white
        textBackgroundView.backgroundColor = JobplanetColor.Green.color
        textBackgroundView.layer.cornerRadius = textBackgroundView.bounds.height/2
        
        menuLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 15.0) ?? UIFont.boldSystemFont(ofSize: 15.0)
        
    }

    
}
