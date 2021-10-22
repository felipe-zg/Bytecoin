//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func fetchData(from currency1: String, to currency2: String) {
        let url = "\(Env.BASE_URL)/\(currency1)/\(currency2)?apikey=\(Env.API_KEY)"
        fetchCurrencyQuotation(url)
    }
    
    func fetchCurrencyQuotation(_ urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                } else {
                    if let safeData = data {
                        let decodedData = decodeData(safeData)
                        print(decodedData!)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func decodeData(_ data: Data) -> CoinModel?{
        let decoder = JSONDecoder()
        do {
            let coinModel = try decoder.decode(CoinModel.self, from: data)
            return coinModel
        } catch {
            print(error)
            return nil
        }
    }
}
