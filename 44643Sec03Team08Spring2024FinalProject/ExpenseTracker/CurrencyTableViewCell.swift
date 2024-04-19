//
//  CurrencyTableViewCell.swift
//  ExpenseTracker
//
//  Created by Harchaithanya Kotapati on 4/17/24.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }

}
