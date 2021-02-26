//
//  CoinResponse.swift
//  ByteCoin
//
//  Created by Victor Batista on 26/02/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var coinManager: CoinManager {
        let manager = CoinManager.init(delegate: self)
        return manager
    }
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    
    func showLoading() {
        loading.isHidden = false
        loading.startAnimating()
    }
    
    func hideLoading() {
        loading.stopAnimating()
    }

}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return coinManager.currencyArray.count
       }
       
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return coinManager.currencyArray[row]
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           let currency = coinManager.currencyArray[row]
           requestCoin(currency)
           
       }
}

extension ViewController: CoinManagerDelegate {
    
    func requestCoin(_ currency: String){
        showLoading()
        coinManager.getCoinPrice(with: currency)
    }
    
    func didFetchCoinInfo(_ coin: CoinResponse,_ currency: String) {
           DispatchQueue.main.async {
               self.bitcoinLabel.text = String(format: "%.1f", coin.rate)
               self.currencyLabel.text = currency
               self.hideLoading()
               self.bitcoinLabel.isHidden = false
               self.currencyLabel.isHidden = false
           }
       }
       
       func didFailWithError(_ error: Error) {
           print(error)
       }
}

