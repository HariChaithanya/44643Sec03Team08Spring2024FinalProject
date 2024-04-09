//
//  DashboardViewController.swift
//  ExpenseTracker
//
//  Created by Harichaithanya kotapati on 21/02/2024.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var predictionLbl: UILabel!
    
    @IBOutlet weak var barChart: BarChartView!
    
    @IBOutlet var costView: UIView!
    
    var model: ExpenseTrackerAll? = nil
    var monthlyExpense: ExpenseModel?
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        self.getPredictedValue()
        self.getExpense()
        
    }
    
    
    
    
    
}
