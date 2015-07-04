//
//  NODPersionalFiancialCell.swift
//  NuoDunProject
//
//  Created by redhat' iMac on 15/7/4.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODPersionalFiancialCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var supposedToPayLabel: UILabel!
    @IBOutlet weak var alreadyPayedLabel: UILabel!
    @IBOutlet weak var unpaidLabel: UILabel!
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
            dateLabel.text = info?.dateString;
            supposedToPayLabel.text = String(info!.supposeToPay!).toCurrency()
            alreadyPayedLabel.text = String(info!.alreadyPayed!).toCurrency()
            unpaidLabel.text = String(info!.unpaid!).toCurrency()
        }
        
    }
}
