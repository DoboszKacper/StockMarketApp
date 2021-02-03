//
//  CompanyStockDetailViewController.swift
//  StockMarket
//
//  Created by Macbook Air on 23/01/2021.
//

import UIKit

class CompanyStockDetailViewController: UIViewController{

    var companyStock: CompanyStock?
    var globalQuote: GlobalQuote?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showData()
    }
    
    @IBOutlet weak var symbolDetailLabel: UILabel!
    @IBOutlet weak var nameDetailLabel: UILabel!
    @IBOutlet weak var percentDetailLabel: UILabel!
    @IBOutlet weak var priceDetailLabel: UILabel!
    @IBOutlet weak var openPriceLabel: UILabel!
    @IBOutlet weak var volumeDetailLabel: UILabel!
    @IBOutlet weak var closePriceLabel: UILabel!
    @IBOutlet weak var ltdLabel: UILabel!
    
    func showData(){
        
        symbolDetailLabel.text = companyStock?.symbol ?? "-"
        nameDetailLabel.text = companyStock?.name ?? "-"
        volumeDetailLabel.text = globalQuote?.volume ?? "-"
        percentDetailLabel.text = globalQuote?.changePercent ?? "-"
        ltdLabel.text = globalQuote?.latestTradingDay ?? "-"
        
        if let currnecy1 = companyStock?.currency, let open = globalQuote?.open {
            openPriceLabel.text = CurrencyService.shared.formatPriceData(from: currnecy1, price: open)
        } else {
            openPriceLabel.text = "-"
        }
        
        if let currency2 = companyStock?.currency, let price = globalQuote?.price {
            priceDetailLabel.text = CurrencyService.shared.formatPriceData(from: currency2, price: price)
        } else {
            priceDetailLabel.text = "-"
        }
        
        if let currency3 = companyStock?.currency, let price = globalQuote?.previuousClose {
            closePriceLabel.text = CurrencyService.shared.formatPriceData(from: currency3, price: price)
        } else {
            closePriceLabel.text = "-"
        }
        
        guard let percent = globalQuote?.changePercent else { return }
        
        if percent.contains("-") {
            priceDetailLabel.textColor = UIColor(named:"ColorForStockPriceDown")
            percentDetailLabel.textColor = UIColor(named:"ColorForStockPriceDown")
        } else if percent.contains("0.0000%") {
            priceDetailLabel.textColor = UIColor(named:"ColorForValueNotChanged")
            percentDetailLabel.textColor = UIColor(named:"ColorForValueNotChanged")
        } else {
            priceDetailLabel.textColor = UIColor(named:"ColorForStockPriceUp")
            percentDetailLabel.textColor = UIColor(named:"ColorForStockPriceUp")
        }
    }
}


