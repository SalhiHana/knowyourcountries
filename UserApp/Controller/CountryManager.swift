//
//  APIService.swift
//  UserApp
//
//  Created by Hana Salhi on 2022-06-05.
//

import Foundation
import UIKit

protocol CountryManagerDelegate {
    func didFetchCountries(_ countryManager: CountryManager, countries: Countries)
    func didFailWithError(error: Error)
}

struct CountryManager {
    
    var delegate : CountryManagerDelegate?
    // http://api.countrylayer.com/v2/all?access_key=f9a133bd54da40240c10ebd1a800ef5a
    let urlString = "https://restcountries.com/v2/all"

    
     func fetchCountries() {
        
        if let url = URL(string: urlString) {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    delegate?.didFailWithError(error: error)
                }
                if let safeData = data {
                    let str = String(decoding: safeData, as: UTF8.self)
                    if
                        let utfData = str.data(using: .utf8),
                        let countries = self.parseJSON(utfData) {
                        self.delegate?.didFetchCountries(self, countries: countries)                        
                    }
                }
            }
            
            task.resume()
        }
    }
        
        private  func parseJSON(_ jsonData: Data) -> Countries? {
            do {
                let newJSONDecoder = JSONDecoder()
                let countries = try newJSONDecoder.decode(Countries.self, from: jsonData)
                return countries
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
    }


