//
//  CountryCollectionViewCell.swift
//  UserApp
//
//  Created by Hana Salhi on 2022-06-17.
//

import UIKit

class CountryCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var countryFlagImageView: UIImageView?
    @IBOutlet private weak var countryNameLabel: UILabel?
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    func setCircularImageView() {
        guard let countryFlagImageView = countryFlagImageView else { return }
        
        countryFlagImageView.layer.masksToBounds = false
        countryFlagImageView.layer.cornerRadius = countryFlagImageView.frame.height / 2.0
        countryFlagImageView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCircularImageView()
    }
    
    func configure(country: Country) {
        countryNameLabel?.text = country.name
        countryFlagImageView?.setImageWithSDWeb(stringUrl: country.flags.png)
    }
}
