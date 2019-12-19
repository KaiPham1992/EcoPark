//
//  TimePicker.swift
//  EcoPark
//
//  Created by Henry on 11/7/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class TimePicker: BaseViewXib {
    
    @IBOutlet weak var tfTime: UITextField!
    
//    var time: String?
    var date: Date?
    

    override func setUpViews() {
        super.setUpViews()

        setPlaceHolder()
    }

    @IBAction func pickerTapped() {
        let popUp = ChooseTimePopUp()
        UIApplication.topViewController()?.view.endEditing(true)

        popUp.showPopUp(completionTime: { time in
            guard let time = time as? Date else {
//                self.time = nil
                self.tfTime.text = ""
                self.tfTime.placeholder = "hh/mm"
                return
            }

            self.date = time
            self.tfTime.text = time.toString(dateFormat: AppDateFormat.HHmm)
        })
    }

    func setPlaceHolder(placeHolder: String = "hh/mm") {
        tfTime.text?.removeAll()
        tfTime.placeholder = placeHolder
    }
}
