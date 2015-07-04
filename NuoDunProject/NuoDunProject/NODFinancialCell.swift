//
//  NODFinancialCell.swift
//  NuoDunProject
//
//  Created by redhat' iMac on 15/6/28.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODFinancialCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var supposedToPayLabel: UILabel!
    @IBOutlet weak var alreadyPayedLabel: UILabel!
    @IBOutlet weak var unpaidLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    func setDataWithInfo(info : NODFinacialInfo?){
        if(info != nil){
            nameLabel.text = info?.userName;
            userIdLabel.text = info?.userID;
            
            supposedToPayLabel.text = String(info!.supposeToPay!).toCurrency()
            alreadyPayedLabel.text = String(info!.alreadyPayed!).toCurrency()
            unpaidLable.text = String(info!.unpaid!).toCurrency()
        }
        
    }
}
