//
//  TimeView.swift
//  EcoPark
//
//  Created by Steve on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class TimeView : BaseViewXib {
    @IBOutlet weak var lblOne: UILabel!
    @IBOutlet weak var lblTwo: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func setUpViews() {
        
    }
    
    func setupTitle(title: String){
        lblTitle.text = title
    }
}
