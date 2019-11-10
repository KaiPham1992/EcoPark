//
//  TimeView.swift
//  EcoPark
//
//  Created by Steve on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

enum ValueType {
    case day
    case hour
    case minute
}

class TimeView : BaseViewXib {
    @IBOutlet weak var lblOne: UILabel!
    @IBOutlet weak var lblTwo: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func setUpViews() {
        
    }
    
    func setupTitle(title: String){
        lblTitle.text = title
    }
    
    func setValue(dateTime: Date, type: ValueType) {
        var value = 0
        if type == .day {
            value = dateTime.day
        } else if type == .hour {
            value = dateTime.hour
        } else {
            value = dateTime.minute
        }
        if value < 10 {
            lblTwo.text = value.description
        } else {
            let digits = value.description.compactMap{ $0.wholeNumberValue }
            lblOne.text = digits.first?.description
            lblTwo.text = digits.last?.description
        }
    }

}
