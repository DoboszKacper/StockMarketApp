//
//  CompanyStockTableViewCell.swift
//  StockMarket
//
//  Created by Macbook Air on 23/01/2021.
//

import UIKit

class CompanyStockTableViewCell: UITableViewCell {

    @IBOutlet weak var percentContainerView: UIView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        percentContainerView.layer.cornerRadius = 4
        percentContainerView.clipsToBounds = true
    }
}
