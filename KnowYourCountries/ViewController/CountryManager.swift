//
//  APIService.swift
//  KnowYourCountries
//
//  Created by Hana Salhi on 2022-06-05.
//

import Foundation
import UIKit

protocol CountryManagerDelegate {
    func didFetchCountries(countries: Countries)
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
                if let data = data,
                   let countries = self.parseJSON(data) {
                    self.delegate?.didFetchCountries(countries: countries)
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


