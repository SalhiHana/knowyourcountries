//
//  CountryTableViewCell.swift
//  UserApp
//
//  Created by Hana Salhi on 2022-06-29.
//

import UIKit
import SDWebImage

class CountryTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView?
    @IBOutlet private weak var titleLabel: UILabel?
    
    func configure(country: Country) {
        self.titleLabel?.text = country.name
        avatarImageView?.setImageWithSDWeb(stringUrl: country.flags.png)
    }
}

extension UIImageView {
    func setImageWithSDWeb(stringUrl: String) {
        self.sd_setImage(with: URL(string: stringUrl, relativeTo: nil))
    }
}

