//
//  ContructionCell.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/7/5.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODContructionCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var proNameLabel: UILabel!
    @IBOutlet weak var workLoad1Label: UILabel!
    @IBOutlet weak var workLoad2Label: UILabel!
    @IBOutlet weak var workLoad3Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setDataWithConstructionInfo(info : NODConstructionInfo?){
        dateLabel.text = info?.constructionDate
        groupNameLabel.text = info?.constructionGroup
        proNameLabel.text = info?.subProjName
        workLoad1Label.text = String(format: "%.2f", info!.workload1!)
        workLoad2Label.text = String(format: "%.2f", info!.workload2!)
        workLoad3Label.text = String(format: "%.2f", info!.workload3!)
    }
}
