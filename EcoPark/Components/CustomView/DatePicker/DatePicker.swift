//
//  DatePicker.swift
//  EcoPark
//
//  Created by Henry on 11/7/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class DatePicker: BaseViewXib{
        
    @IBOutlet weak var tfDate: UITextField!
    var date: String?
    
    override func setUpViews() {
        super.setUpViews()
        
        setPlaceHolder()
    }
    
    @IBAction func pickerTapped() {
        let popUp = ChooseDatePopUp()
        UIApplication.topViewController()?.view.endEditing(true)

        popUp.showPopUp(currentDate: nil, completionDate: { date in
            guard let date = date as? Date else {
                self.date = nil
                self.tfDate.text = ""
                self.tfDate.placeholder = "dd/mm/yyyy"
                return
            }
            
            self.date = date.toString(dateFormat: AppDateFormat.ddMMYYYYTransaction)
            self.tfDate.text = date.toString(dateFormat: AppDateFormat.ddMMYYYYTransaction)
        })
    }
    
    func setPlaceHolder(placeHolder: String = "dd/mm/yyyy") {
        tfDate.text?.removeAll()
        tfDate.placeholder = placeHolder
    }
}
