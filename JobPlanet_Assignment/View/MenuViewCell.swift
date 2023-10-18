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
    
    override var isHighlighted: Bool {
        didSet {
            isHighlighted ? selected() : notSelected()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            isSelected ? selected() : notSelected()
        }
    }

    func configure(with text: String, index: Int) {
        menuLabel.text = text
        
        if index == 0 {
            selected()
        } else {
            notSelected()
        }
    }
    
    func selected() {
        menuLabel.textColor = .white
        textBackgroundView.backgroundColor = JobplanetColor.Green.color
        textBackgroundView.layer.cornerRadius = textBackgroundView.bounds.height/2

        menuLabel.font = UIFont(name: JobPlanetFont.Bold.font, size: 15.0) ?? UIFont.boldSystemFont(ofSize: 15.0)
    }
    
    func notSelected() {
        menuLabel.textColor = JobplanetColor.Gray01.color
        textBackgroundView.backgroundColor = .white
        textBackgroundView.layer.cornerRadius = textBackgroundView.bounds.height/2
        textBackgroundView.layer.borderWidth = 1
        textBackgroundView.layer.borderColor = JobplanetColor.Gray03.color.cgColor

        menuLabel.font = UIFont(name: JobPlanetFont.Medium.font, size: 15.0) ?? UIFont.boldSystemFont(ofSize: 15.0)
    }
}
