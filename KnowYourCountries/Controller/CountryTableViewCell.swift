//
//  CountryTableViewCell.swift
//  KnowYourCountries
//
//  Created by Hana Salhi on 2022-06-29.
//

import UIKit
import SDWebImage
import RealmSwift


protocol CountryTableViewDelegate {
    func didTapFavorite()
}

class CountryTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView?
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var isFavoriteButton: UIButton!
    
    var delegate: CountryTableViewDelegate?
    
    func configure(country: Country) {
        self.titleLabel?.text = country.name
        avatarImageView?.setImageWithSDWeb(stringUrl: country.flags.png)
        let favoriteImageName = Favorite.isFavorite(countryName: country.name) == true ? "star.fill" : "star"
        isFavoriteButton.setImage(UIImage(systemName: favoriteImageName), for: .normal)
    }
    
    @IBAction func isFavoriteButtonPressed(_ sender: Any) {
        guard let countryName = titleLabel?.text else { return }

        if Favorite.isFavorite(countryName: countryName) == true {
            Favorite.deleteFavorite(countryName: countryName)
        } else {
            Favorite.addFavorite(countryName: countryName)
        }
        
        delegate?.didTapFavorite()
    }
}
extension UIImageView {
    func setImageWithSDWeb(stringUrl: String) {
        self.sd_setImage(with: URL(string: stringUrl, relativeTo: nil))
    }
}

