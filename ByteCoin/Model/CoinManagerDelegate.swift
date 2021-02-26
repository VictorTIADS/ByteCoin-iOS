//
//  CoinManagerDelegate.swift
//  ByteCoin
//
//  Created by Victor Batista on 26/02/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    
    func didFetchCoinInfo(_ coin: CoinResponse,_ currency: String)
    func didFailWithError(_ error: Error)
    
}
