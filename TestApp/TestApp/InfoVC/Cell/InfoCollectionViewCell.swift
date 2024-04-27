//
//  InfoCollectionViewCell.swift
//  TestApp
//
//  Created by Stanislav Tereshchenko on 26.04.2024.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        customizingCell()
    }
    
    func customizingCell() {
        cellLabel.font = UIFont(name: "Gilroy-Black", size: 30)
        cellLabel.textColor = .white
        self.layer.cornerRadius = self.bounds.size.height / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = .clear
    }
    

}
