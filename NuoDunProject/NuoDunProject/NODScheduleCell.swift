//
//  NODScheduleCell.swift
//  NuoDunProject
//
//  Created by 乐星宇 on 15/7/25.
//  Copyright (c) 2015年 lxzhh. All rights reserved.
//

import UIKit

extension String{
    func dateComponent() -> (String,String,String)?{
        println("date \(self)")
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
         NSCalendar.currentCalendar()
        let date = dateFormatter.dateFromString(self)
        if  date != nil{
            let dateComponent = NSCalendar.currentCalendar().components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: date!)
            let year = String(dateComponent.year)
            let month = String(dateComponent.month)
            let day = String(dateComponent.day)
            
            return ( year , month , day )
            
        }
        return ("", "", "")

    }
}

class NODScheduleCell: UITableViewCell {

    @IBOutlet weak var projLocationLabel: UILabel!
    @IBOutlet weak var projNameLabel: UILabel!
    @IBOutlet weak var startDateMLabel: UILabel!
    @IBOutlet weak var startDateYLabel: UILabel!
    @IBOutlet weak var startDateDLabel: UILabel!
    @IBOutlet weak var endDateMLabel: UILabel!
    @IBOutlet weak var endDateYlabel: UILabel!
    @IBOutlet weak var endDateDLabel: UILabel!
    @IBOutlet weak var progressTextLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
   
    
    func setDateWithSchedule(s1 : NODSchedule?){
        if let s = s1{
            projNameLabel.text = s.subprojName
            projLocationLabel.text = s.projLocation
            let startDate = s.startDate?.dateComponent()
            startDateYLabel.text = startDate!.0
            startDateMLabel.text = startDate!.1
            startDateDLabel.text = startDate!.2
            let endDate = s.endDate?.dateComponent()
            endDateYlabel.text = endDate!.0
            endDateMLabel.text = endDate!.1
            endDateDLabel.text = endDate!.2
            progressTextLabel.text = "进度：\(s.completedPercent!)%"
            progressView.progress = s.completedPercent!/100.0
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
