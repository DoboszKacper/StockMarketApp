//
//  StockListViewController.swift
//  StockMarket
//
//  Created by Macbook Air on 20/01/2021.
//
import UIKit
import Alamofire

class StockListViewController: UITableViewController, UISearchBarDelegate{
    
    var loadedCompanys: [CompanyStock] = []
    var loadedPrices: [GlobalQuote] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBar.delegate = self
        fetchAllData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        loadedCompanys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyStockCell") as! CompanyStockTableViewCell
        let company = loadedCompanys[indexPath.row]
        
        cell.nameLabel.text = company.name
        cell.symbolLabel.text = company.symbol
        
        let loadedPrice = loadedPrices.first(where: { $0.symbol == company.symbol })
                                      
        cell.valueLabel.text = CurrencyService.shared.formatPriceData(from: company.currency, price: loadedPrice?.price ?? "")
        cell.percentLabel.text = loadedPrice?.changePercent ?? "-"
        
        let percent = loadedPrice?.changePercent ?? "nil"
        
        if (percent.contains("-")) {
            cell.percentContainerView.backgroundColor = UIColor(named:"ColorForStockPriceDown")
            cell.valueLabel.textColor = UIColor(named:"ColorForStockPriceDown")
        } else if (percent.contains("0.0000%") || percent.contains("nil")) {
            cell.percentContainerView.backgroundColor  = UIColor(named:"ColorForValueNotChanged")
            cell.valueLabel.textColor = UIColor(named:"ColorForValueNotChanged")
        } else {
            cell.percentContainerView.backgroundColor = UIColor(named:"ColorForStockPriceUp")
            cell.valueLabel.textColor = UIColor(named:"ColorForStockPriceUp")
        }

        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowCompanyStock", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowCompanyStock" else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let detailViewController = segue.destination as! CompanyStockDetailViewController
        
        let loadedCompany = loadedCompanys[safe: indexPath.row]
        detailViewController.companyStock = loadedCompany
        
        let loadedPrice = loadedPrices.first(where: { $0.symbol == loadedCompany?.symbol })
        detailViewController.globalQuote = loadedPrice
    }
    
    
    @IBAction func reload(_ sender: Any?) {
        fetchAllData()
    }
    
    private func fetchAllData(symbol: String? = nil) {
        
        if (symbol != nil){
            Key.setDefaultSymbolValue(value: symbol ?? "")
        }
        let symbolValue = symbol ?? Key.getDefaultSymbolValue()
        
        let dispatchGroup = DispatchGroup()
        
        fetchNameAndSymbol(for: symbolValue) { [weak self] in

            guard let self = self else { return }

            self.loadedCompanys.forEach { (companyStock) in
                dispatchGroup.enter()
                self.fetchPrices(for: companyStock.symbol) {
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                self.tableView.reloadData()
            }
        }
    }
    
    private func fetchPrices(for symbol: String, completion: @escaping (() -> ())) {

        //Loading price and percentage
        AF.request(Key.getUrlQuoteEndpoint(symbol: symbol),
                   method: .get,
                   headers: Key.Headers.headers).responseJSON { response in
                    if let error = response.error{
                        self.presentError(error, "Request Failed")
                        completion()
                        return
                    }
                    
                    if let data = response.data {
                        do {
                            let container =  try JSONDecoder().decode(GlobalQuoteContainer.self, from: data)

                            self.loadedPrices.append(container.globalQuote)
                            completion()
                        } catch {
                            completion()
                            self.presentError(error, "Free Api limit")
                        }
                    }
                }
    }
    
    private func fetchNameAndSymbol(for symbol: String, completion: @escaping (() -> ())) {
        
        //Loading Symbol and Name
        AF.request(Key.getUrlSearchEndpoint(symbol: symbol),
                   method: .get,
                   headers: Key.Headers.headers).responseJSON { [self] response in
                    if let error = response.error{
                        self.presentError(error, "Request Failed")
                        return
                    }
                    if let data = response.data{
                        do {
                            let container =  try JSONDecoder().decode(CompanyStockContainer.self, from: data)
                            self.loadedCompanys = container.companys
                            completion()
                        } catch{
                            completion()
                            self.presentError(error, "API request limit ")
                        }
                    }
                }
    }
    
    func presentError(_ error: Error,_ title: String) {
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        alert.addAction(UIAlertAction(title: "Reload", style: .default){_ in self.reload(nil) })
        self.present(alert, animated: true)
    }
    
    // MARK: Search Bar section
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchAllData(symbol: searchBar.text)
    }
    
}


