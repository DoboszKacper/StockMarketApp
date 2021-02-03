//
//  CurrencyService.swift
//  StockMarket
//
//  Created by Macbook Air on 26/01/2021.
//

import Foundation

class CurrencyService {
    
    private init() {}
    
    static let shared = CurrencyService()
    
    public func formatPriceData(from currency: String, price: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = currency
        numberFormatter.numberStyle = .currency
        numberFormatter.formatterBehavior = .behavior10_4
        guard let double = Double(price) else { return "-" }
        let nsNumber = NSNumber(value: double)
        
        return numberFormatter.string(from: nsNumber) ?? ""
    }
}
