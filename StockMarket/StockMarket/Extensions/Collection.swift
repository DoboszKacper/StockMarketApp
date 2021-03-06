//
//  Collection.swift
//  StockMarket
//
//  Created by Macbook Air on 26/01/2021.
//

import Foundation

extension Collection {
    
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
