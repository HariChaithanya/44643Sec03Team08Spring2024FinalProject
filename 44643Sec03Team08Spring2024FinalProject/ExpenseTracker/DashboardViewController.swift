//
//  DashboardViewController.swift
//  ExpenseTracker
//
//  Created by Harichaithanya kotapati on 21/02/2024.
//

import UIKit
import CoreML
import Charts
import DGCharts
import AnimatedGradientView


//ChartViewDelegate is a protocol that conatins all the required methods that will help to add chart and perfrom opeartions on charts
class DashboardViewController: UIViewController, ChartViewDelegate, ExpenseUpdatedDelegate, CurrencySelectionDelegate {
    
    func presentCurrencyViewController() {
        let currencyVC = CurrencyViewController()
        currencyVC.delegate = self
        self.present(currencyVC, animated: true, completion: nil)
    }
    
    func didSelectCurrency(_ currencyCode: String) {
    }
    
    
    //applying the fradient colors
    func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        let topColor = UIColor(red: 250/255, green: 208/255, blue: 219/255, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 255/255, green: 234/255, blue: 156/255, alpha: 1.0).cgColor
        
        gradientLayer.colors = [topColor, bottomColor]
        self.view.layer.sublayers?.filter({ $0 is CAGradientLayer }).forEach({ $0.removeFromSuperlayer() })
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func expenseUpdated() {
        
        self.getExpense()
        self.getPredictedValue()
    }
    
    //method present in ChartViewDelegate
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        print(entry)
        //get the value of the expense which is in y axis
        let value = entry.y
        //gets the index of the category
        let index = Int(entry.x)
        //check if it is a empty expense
        if value > 0 {
            //if not empty then goto update/ delete VC
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateOrDeleteExpenseViewController") as! UpdateOrDeleteExpenseViewController
            //pass the yaxis value which is
            vc.expense = value
            vc.selectedCategory = self.categoriesArray[index]
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var predictionLbl: UILabel!
    
    @IBOutlet weak var barChart: BarChartView!
    
    @IBOutlet var costView: UIView!
    
    var model: ExpenseTrackerAll? = nil
    var monthlyExpense: ExpenseModel?
    
    var categoriesArray = ["Rent", "Groceries", "Transportation", "Food", "Stationery", "Healthcare", "Entertainment", "Miscellaneous"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.applyGradientBackground()
        
        self.navigationItem.title = "Dashboard"
        self.navigationItem.hidesBackButton = true
        costView.layer.cornerRadius = 8
        
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = "MMMM, yyyy"
        let str = dtFormatter.string(from: Date())
        monthLbl.text = str
        
        barChart.noDataText = "No chart data available,\n You didn't spend any amount in this month."
        barChart.noDataTextColor = .white
        barChart.noDataFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        barChart.noDataTextAlignment = .center
        barChart.delegate = self
        
        self.getPredictedValue()
        self.getExpense()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func getPredictedValue() -> Void {
        
        do {
            model = try ExpenseTrackerAll(configuration: MLModelConfiguration())
            
        } catch {
            
            return
        }
        
        let dtFormatter = DateFormatter()
        dtFormatter.dateFormat = "MMM"
        let str = dtFormatter.string(from: Date())
        
        let inputFeatures = ExpenseTrackerAllInput(Month: str,
                                                   Rent: Int64(monthlyExpense?.Rent ?? 0.0),
                                                   Groceries: Int64(monthlyExpense?.Groceries ?? 0.0),
                                                   Transportation: Int64(monthlyExpense?.Transportation ?? 0.0),
                                                   Food: Int64(monthlyExpense?.Food ?? 0.0),
                                                   Stationery: Int64(monthlyExpense?.Stationery ?? 0.0),
                                                   Healthcare: Int64(monthlyExpense?.Healthcare ?? 0.0),
                                                   Entertainment: Int64(monthlyExpense?.Entertainment ?? 0.0),
                                                   OTT_Subscrption: Int64(monthlyExpense?.OTT_Subscrption ?? 0.0),
                                                   Miscellaneous: Int64(monthlyExpense?.Miscellaneous ?? 0.0))
        do {
            
            let prediction = try model?.prediction(input: inputFeatures)
            
            let result = prediction?.Monthly_expenses ?? 0
            self.predictionLbl.text = String(format: "Predicted Value: $%d", result)
            
        } catch {
            print("Error while making prediction: \(error)")
        }
    }
    
    func getExpense() -> Void {
        
        FireStoreOperations.fetchExense { res in
            
            self.monthlyExpense = res
            self.calculateTotal()
            self.createBarChart()
        }
    }
    
    func calculateTotal() -> Void {
        
        var total: Double = 0
        
        total += monthlyExpense?.Rent ?? 0.0
        total += monthlyExpense?.Groceries ?? 0.0
        total += monthlyExpense?.Transportation ?? 0.0
        total += monthlyExpense?.Food ?? 0.0
        total += monthlyExpense?.Stationery ?? 0.0
        total += monthlyExpense?.Healthcare ?? 0.0
        total += monthlyExpense?.Entertainment ?? 0.0
        total += monthlyExpense?.OTT_Subscrption ?? 0.0
        total += monthlyExpense?.Miscellaneous ?? 0.0
        
        totalLbl.text = String(format: "Total Spend: $%0.2f", total)
    }
    
    func createBarChart() -> Void {
        
        //Supply Data
        var entries = [BarChartDataEntry]()
        
        entries.append(BarChartDataEntry(x: Double(0),
                                         y: monthlyExpense?.Rent ?? 0.0))
        entries.append(BarChartDataEntry(x: Double(1),
                                         y: monthlyExpense?.Groceries ?? 0.0))
        entries.append(BarChartDataEntry(x: Double(2),
                                         y: monthlyExpense?.Transportation ?? 0.0))
        entries.append(BarChartDataEntry(x: Double(3),
                                         y: monthlyExpense?.Food ?? 0.0))
        entries.append(BarChartDataEntry(x: Double(4),
                                         y: monthlyExpense?.Stationery ?? 0.0))
        entries.append(BarChartDataEntry(x: Double(5),
                                         y: monthlyExpense?.Healthcare ?? 0.0))
        entries.append(BarChartDataEntry(x: Double(6),
                                         y: monthlyExpense?.Entertainment ?? 0.0))
        entries.append(BarChartDataEntry(x: Double(7),
                                         y: monthlyExpense?.Miscellaneous ?? 0.0))
        
        
        let set = BarChartDataSet(entries: entries, label: "Expense")
        set.colors = ChartColorTemplates.colorful()
        set.valueTextColor = .white
        
        let data = BarChartData(dataSet: set)
        barChart.data = data
        
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Rent", "Grocery", "Transport", "Food", "Stationery", "Health", "Entertain", "Misc"])
        
        barChart.leftAxis.axisLineColor = .white
        barChart.leftAxis.labelTextColor = .white
        
        
        barChart.xAxis.labelPosition = .bottom
        barChart.rightAxis.enabled = false
        barChart.legend.enabled = false
        barChart.xAxis.labelTextColor = .white
        
        
        barChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    @IBAction func add(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddExpenseViewController") as! AddExpenseViewController
        
        vc.expense = monthlyExpense
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
