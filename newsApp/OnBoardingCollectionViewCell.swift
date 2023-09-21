//
//  OnBoardingCollectionViewCell.swift
//  newsApp
//
//  Created by Seda Gültekin on 10.09.2023.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
//static let identifier = String(describing: OnBoardingCollectionViewCell.self)
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    func setup(_ slide:OnBoardingSlide){
        slideImageView.image = slide.image
        titleLabel.text = slide.title
        textLabel.text = slide.description   }
}
