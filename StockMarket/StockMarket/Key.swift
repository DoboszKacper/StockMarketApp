//
//  Key.swift
//  StockMarket
//
//  Created by Macbook Air on 25/01/2021.
//

import Foundation
import Alamofire

struct Key {
    
    private static let Domain = Domains.Alpha
    private static var DefaultSymbolValue = "AAPL"

    private struct Domains {
            static let Alpha = "https://alpha-vantage.p.rapidapi.com"
    }
    
    static func getDefaultSymbolValue() -> String {
            return DefaultSymbolValue
    }
    
    static func setDefaultSymbolValue(value: String) {
        DefaultSymbolValue = value
    }
        
    static func getUrlSearchEndpoint(symbol: String) -> String {
            return Domain + "/query?keywords=\(symbol)&function=SYMBOL_SEARCH&datatype=json"
    }
        
        
    static func getUrlQuoteEndpoint(symbol: String) -> String {
        return Domain + "/query?function=GLOBAL_QUOTE&symbol=\(symbol)&datatype=json"
        
    }
    
    struct Headers {
        static let headers: HTTPHeaders = [
             "x-rapidapi-key": "ebc81ec9aemsh899920cde6fc4bap1bdb27jsna382f4a013e6",
             "x-rapidapi-host": "alpha-vantage.p.rapidapi.com"
         ]
    }
}
