//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateQuotation(_ coinManager: CoinManager, quotation: Double)
}

struct CoinManager {
    var delegate: CoinManagerDelegate?
    let currencyArray = ["USD", "AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","ZAR"]

    func getCoinQuotation(for currency1: String, in currency2: String) {
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
                        DispatchQueue.main.async {
                            if let safeData = decodedData {
                                self.delegate?.didUpdateQuotation(self, quotation: safeData.rate)
                            }
                        }
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
