//
//  NODAddObjectCell.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/7/19.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODAddObjectCell: UITableViewCell {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var selectTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
