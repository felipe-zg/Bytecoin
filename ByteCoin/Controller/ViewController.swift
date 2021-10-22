//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var quotationLabel: UILabel!
    @IBOutlet weak var targetCurrencyLabel: UILabel!
    var coinManager = CoinManager()
    var inCurrency = "USD"
    var forCurrency = "USD"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        coinManager.delegate = self
    }


}

//MARK: - UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(component == 1) {
            inCurrency = coinManager.currencyArray[row]
        }else {
            forCurrency = coinManager.currencyArray[row]
        }
        targetCurrencyLabel.text = inCurrency
        coinManager.getCoinQuotation(for: forCurrency, in: inCurrency)
    }
}

//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    func didUpdateQuotation(_ coinManager: CoinManager, quotation: Double) {
        self.quotationLabel.text = String(format: "%.2f", quotation)
    }
}
