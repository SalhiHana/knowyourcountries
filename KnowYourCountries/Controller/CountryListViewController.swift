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
    
    var countries: Countries = []
    var filteredCountries: Countries = []
    
    var segmentedControl: UISegmentedControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        searchBar.delegate = self
        
        countryManager.delegate = self
        countryManager.fetchCountries()
        table.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryTableViewCell")
        
        setUpSegmentedControl()
        setupNavigationBar()
    }
    
    private func setUpSegmentedControl() {
        segmentedControl = UISegmentedControl (items: ["All","Favorites"])
        segmentedControl?.selectedSegmentIndex = 0
        segmentedControl?.backgroundColor = UIColor(named: "primaryColor")
        segmentedControl?.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    @objc func segmentedValueChanged() {
        table.reloadData()
    }
    
    private func setupNavigationBar() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
        navigationItem.rightBarButtonItem = searchButton
        navigationController?.navigationBar.tintColor = UIColor(named: "primaryColor")
        
        navigationItem.titleView = segmentedControl
        
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
    
    var getCountries: [Country]? {
        guard let segmentedControl = segmentedControl else { return nil }
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            if isSearching ,let searchText = searchBar.text, !searchText.isEmpty {
                return filteredCountries
            } else {
                return countries
            }
        case 1:
            if isSearching, let searchText = searchBar.text, !searchText.isEmpty {
                return filteredCountries.filter { Favorite.isFavorite(countryName: $0.name) == true }
            } else {
                return countries.filter { Favorite.isFavorite(countryName: $0.name) == true }
            }
                
        default:
            break
        }

        return nil
    }
}
extension CountryListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getCountries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let countries = getCountries else { return UITableViewCell() }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as? CountryTableViewCell {
            cell.configure(country: countries[indexPath.row])
            cell.delegate = self
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let countries = getCountries else { return }
        let countryDetailViewController = CountryDetailViewController(nibName: "CountryDetailViewController", bundle: nil)
        countryDetailViewController.country = countries[indexPath.row]
        countryDetailViewController.countries = countries
        countryDetailViewController.delegate = self
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

extension CountryListViewController: CountryTableViewDelegate {
    func didTapFavorite() {
        self.table.reloadData()
    }
}
