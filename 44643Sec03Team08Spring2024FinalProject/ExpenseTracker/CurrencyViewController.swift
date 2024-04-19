//
//  CurrencyViewController.swift
//  ExpenseTracker
//
//  Created by Harchaithanya Kotapati on 4/17/24.
//

import UIKit


struct ConversionRate {
    let currencyCode: String
    let rate: Double
}

class CurrencyViewController: UIViewController {

    @IBOutlet weak var dataTV: UITableView!
    
    @IBOutlet weak var fromBtn: UIButton!
    @IBOutlet weak var toBtn: UIButton!
    
    @IBOutlet weak var amountTF: UITextField!
    var currencyList: [String] = []
    var conversionRates = [ConversionRate]()
    
    var selectedCurrency = "USD"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountTF.attributedPlaceholder = NSAttributedString(string: "Amount", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        currencyList = Locale.isoCurrencyCodes
        print(currencyList)
        
        self.dataTV.delegate = self
        self.dataTV.dataSource = self
        
        setFrom()
        setTo()
        
    }
    
    
    func setFrom() -> Void {
        
        var optionsArray = [UIAction]()
        for currency in currencyList {
            
            let action = UIAction(title: currency, state: .off, handler: { (action: UIAction) in
                
                print("Pop-up action")
                print(action.title)
                
                self.conversionRates.removeAll()
                self.selectedCurrency = action.title
                self.getConversions()
            })
            optionsArray.append(action)
        }
        
        if let index = currencyList.firstIndex(of: "USD") {
            optionsArray[index].state = .on
        }
        
        
        
        let optionsMenu = UIMenu(title: "", options: .displayInline, children: optionsArray)
        fromBtn.menu = optionsMenu
        
        self.getConversions()
    }
    
    func setTo() -> Void {
        
        var optionsArray = [UIAction]()
        for currency in currencyList {
            
            let action = UIAction(title: currency, state: .off, handler: { _ in
                
            })
            optionsArray.append(action)
        }
        

        
        let optionsMenu = UIMenu(title: "", options: .displayInline, children: optionsArray)
        toBtn.menu = optionsMenu
    }
    
    func getConversions() -> Void {
     
        let base_currency = self.selectedCurrency
        let urlString = "https://v6.exchangerate-api.com/v6/50c5a258ab511112c23359df/latest/\(base_currency)"
        

        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
        
                do {
            
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        
                        if let conversionRatesDict = json["conversion_rates"] as? [String: Double] {
                     
                            
                            for (currencyCode, rate) in conversionRatesDict {
                                let conversionRate = ConversionRate(currencyCode: currencyCode, rate: rate)
                                self.conversionRates.append(conversionRate)
                            }
                            
                        
                            DispatchQueue.main.async {
                                
                                self.conversionRates = self.conversionRates.sorted(by: { $0.currencyCode < $1.currencyCode })
                                
                                self.dataTV.reloadData()
                            }
                        }
                    }
                } catch {
                    print("Error parsing JSON: \(error.localizedDescription)")
                }
            }
            
        
            task.resume()
        }
    }
    
    
    @IBAction func convert(_ sender: Any) {
        
        
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversionRates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CurrencyTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "currencyCell") as? CurrencyTableViewCell
        
        cell.contentView.backgroundColor = .clear
        
        let rate = conversionRates[indexPath.row]
        cell.currencyLbl.text = rate.currencyCode
        cell.rateLbl.text = "\(rate.rate)"
        
        return cell
        
    }
}
