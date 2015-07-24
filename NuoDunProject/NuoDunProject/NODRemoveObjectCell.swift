//
//  NODRemoveObjectCell.swift
//  NuoDunProject
//
//  Created by lxzhh on 15/7/19.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

class NODRemoveObjectCell: UITableViewCell {

    @IBOutlet weak var countPromptLabel: UILabel!
    @IBOutlet weak var countField: UITextField!
    @IBOutlet weak var objectNameField: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
