//
//  CountryDetailViewController.swift
//  UserApp
//
//  Created by Hana Salhi on 2022-06-09.
//

import Foundation
import UIKit

class CountryDetailViewController: UIViewController {
    @IBOutlet private weak var nameStackView: UIStackView!
    
    @IBOutlet private weak var countryFlagImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var capitalLabel: UILabel!
    @IBOutlet private weak var populationLabel: UILabel!
    @IBOutlet private weak var regionLabel: UILabel!
    @IBOutlet private weak var demonymLabel: UILabel!
    @IBOutlet private weak var areaLabel: UILabel!
    @IBOutlet private weak var timezonesLabel: UILabel!
    @IBOutlet private weak var callingcodesLabel: UILabel!
    @IBOutlet private weak var languagesLabel: UILabel!
    @IBOutlet private weak var currenciesLabel: UILabel!
    
    @IBOutlet private weak var borderViewSeparator: UIView!
    @IBOutlet private weak var borderView: UIView!
    @IBOutlet var bordersCollectionView: UICollectionView!
    
    var country: Country?
    var countries: Countries = []
    
    var borderIsClickable = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bordersCollectionView.delegate = self
        bordersCollectionView.dataSource = self
        bordersCollectionView.register(UINib(nibName:"CountryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:"CountryCollectionViewCell")
        
        borderView.isHidden = country?.borders == nil
        borderViewSeparator.isHidden = country?.borders == nil
        
    }
    
    func configure() {
        if let country = country {
            countryFlagImageView.setImageWithSDWeb(stringUrl: country.flags.png)
            nameLabel.text = country.name
            capitalLabel.text = country.capital
            populationLabel.text = String(country.population)
            regionLabel.text = country.region.rawValue
            demonymLabel.text = country.demonym
            areaLabel.text = String(country.area ?? 0.0)
            timezonesLabel.text = country.timezones.joined(separator: ", ")
            callingcodesLabel.text = country.callingCodes.joined(separator: ", ")
            languagesLabel.text = country.languages.compactMap({ $0.name }).joined(separator: ", ")
            currenciesLabel.text = country.currencies?.compactMap({ $0.name }).joined(separator: ", ")
        }
    }
    
}

extension CountryDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return country?.borders?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let borders = country?.borders,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountryCollectionViewCell", for: indexPath) as? CountryCollectionViewCell else {
                return CountryCollectionViewCell()
            }
        
        let element = borders[indexPath.row]
        if let country = countries.first(where: { $0.alpha3Code == element }) {
            cell.configure(country: country)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        if !borderIsClickable { return } same as below
        guard borderIsClickable else { return }
        let countryDetailViewController = CountryDetailViewController(nibName: "CountryDetailViewController", bundle: nil)
        guard
            let selectedBorder = country?.borders?[indexPath.row],
            let countryToOpenIndex = countries.firstIndex(where: { $0.alpha3Code == selectedBorder }) else { return }
        countryDetailViewController.country = countries[countryToOpenIndex]
        countryDetailViewController.countries = countries
        countryDetailViewController.borderIsClickable = false  
        navigationController?.pushViewController(countryDetailViewController, animated: true)
    }
}
