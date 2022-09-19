//
//  CountryListViewController.swift
//  KnowYourCountries
//
//  Created by Hana Salhi on 2022-05-25.
//

import UIKit
//https://restcountries.com/v2/all

class CountryListViewController: UIViewController {
    
    @IBOutlet private weak var table: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableViewSafeAreaTopConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var tableViewSearchBarTopConstraint: NSLayoutConstraint!
    var countryManager = CountryManager()
    var isSearching = false
    
    struct User {
        let imageName: String
        let title: String
        let subTitle:String
    }
    
    var countries: Countries = []
    var filteredCountries: Countries = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        searchBar.delegate = self
        
        countryManager.delegate = self
        countryManager.fetchCountries()
        table.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryTableViewCell")
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
        navigationItem.rightBarButtonItem = searchButton        
        navigationController?.navigationBar.tintColor = UIColor(named: "primaryColor")
                
        navigationItem.title = "Country List"
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "primaryColor") ?? UIColor()]

        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }
    
    @objc func didTapSearchButton(_ sender: UIBarButtonItem) {
        isSearching.toggle()
        tableViewSafeAreaTopConstraint.isActive = !isSearching
        tableViewSearchBarTopConstraint.isActive = isSearching
    }
}
extension CountryListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let searchText = searchBar.text, !searchText.isEmpty {
            return filteredCountries.count
        } else {
            return countries.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var data: Country
        if let searchText = searchBar.text, !searchText.isEmpty {
            data = filteredCountries[indexPath.row]
        } else {
            data = countries[indexPath.row]
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell {
            cell.configure(country: data)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countryDetailViewController = CountryDetailViewController(nibName: "CountryDetailViewController", bundle: nil)
         countryDetailViewController.country = isSearching ? filteredCountries[indexPath.row] : countries[indexPath.row]
        countryDetailViewController.countries = countries
        navigationController?.pushViewController(countryDetailViewController, animated: true)
        
    }
}

extension CountryListViewController: CountryManagerDelegate {
    
    func didFetchCountries(_ countryManager: CountryManager, countries: Countries) {
        DispatchQueue.main.async {
            self.countries = countries
            self.filteredCountries = countries
            self.table.reloadData()
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension CountryListViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCountries = countries.filter({ $0.name.starts(with: searchText) })
        table.reloadData()
    }
}

extension UIViewController {
    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}
