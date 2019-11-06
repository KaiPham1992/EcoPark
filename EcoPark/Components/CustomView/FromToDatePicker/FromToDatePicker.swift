//
//  FromToDatePicker.swift
//  EcoPark
//
//  Created by Henry on 11/5/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class FromToDatePicker: BaseViewXib {
    
    @IBOutlet weak var lbFrom: UILabel!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var fieldFrom: UITextField!
    @IBOutlet weak var fieldTo: UITextField!
    
    var from: Date?
    var to: Date?
    
    override func setUpViews() {
        super.setUpViews()
        setUpUI()
    }
    
    func setTitleAndPlaceHolder(fromTitle: String, toTitle: String, fromPlaceHolder: String = "dd/mm/yyyy", toPlaceHolder: String = "dd/mm/yyyy") {
        lbFrom.text = fromTitle
        lbTo.text = toTitle
        fieldFrom.placeholder = fromPlaceHolder
        fieldTo.placeholder = toPlaceHolder
    }
    
    func setUpUI() {
        self.backgroundColor = .clear
        
        self.lbFrom.textColor = AppColor.color_169_169_169
        self.lbTo.textColor = AppColor.color_169_169_169
        
        self.fieldTo.textColor = AppColor.color_0_129_255
        self.fieldFrom.textColor = AppColor.color_0_129_255
        
        self.fieldTo.backgroundColor = .clear
        self.fieldFrom.backgroundColor = .clear
        
    }
    
    @IBAction func btnFromTapped() {
        let popUp = ChooseDatePopUp()
        UIApplication.topViewController()?.view.endEditing(true)

        popUp.showPopUp(currentDate: from, completionDate: { date in
            guard let date = date as? Date else {
                self.from = nil
                self.fieldFrom.text = ""
                self.fieldFrom.placeholder = "dd/mm/yyyy"
                self.fieldFrom.placeHolderColor = AppColor.color_0_129_255
                return
            }
            
            self.from = date
            self.fieldFrom.text = date.toString(dateFormat: AppDateFormat.ddMMYYYYTransaction)
        })
    }
    
    @IBAction func btnToTapped() {
        UIApplication.topViewController()?.view.endEditing(true)
        let popUp = ChooseDatePopUp()
        
        popUp.showPopUp(currentDate: to, completionDate: { date in
            guard let date = date as? Date else {
                self.to = nil
                self.fieldTo.text = ""
                self.fieldTo.placeholder = "dd/mm/yyyy"
                self.fieldTo.placeHolderColor = AppColor.color_0_129_255
                return
            }
            self.to = date
            self.fieldTo.text = date.toString(dateFormat: AppDateFormat.ddMMYYYYTransaction)
        })
    }
}
