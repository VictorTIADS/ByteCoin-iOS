//
//  CoinResponse.swift
//  ByteCoin
//
//  Created by Victor Batista on 26/02/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "8BEB4604-3507-42D0-BF4D-C01CA6DBD31B"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(with currency: String){
        let urlString = "\(baseURL)/\(currency)?apiKey=\(apiKey)"
        peformRequest(urlString, currency)
    }
    
    func peformRequest(_ urlString: String,_ currency: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let coinInfo = self.parseJSON(safeData) {
                        self.delegate?.didFetchCoinInfo(coinInfo,currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> CoinResponse? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(CoinResponse.self, from: weatherData)
            return decoderData
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
