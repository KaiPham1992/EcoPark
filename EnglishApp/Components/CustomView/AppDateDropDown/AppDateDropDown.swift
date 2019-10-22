//
//  AppTextField.swift
//  Ipos
//
//  Created by Kai Pham on 4/19/19.
//  Copyright © 2019 edward. All rights reserved.
//


//

import UIKit
import DropDown

//protocol AppTextFieldDropDownDelegate: class {
//    func didChangedValue(sender: AppDropDown, item: Any)
//}

class AppDateDropDown: BaseViewXib {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var vContain: UIView!
    
    var selectedDate: Date?
//    weak var delegateDropDown: AppTextFieldDropDownDelegate?
    
    
    func setTitleAndPlaceHolder(title: String? = nil, placeHolder: String? = nil) {
        if title != nil {
            self.lbTitle.text = title
        }
        
        if placeHolder != nil {
            self.tfInput.placeholder = placeHolder
            tfInput.placeHolderColor = .black
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        
    }
    
    @IBAction func btnActionTapped() {
        let popUp = PopUpSelectDate()
        popUp.showPopUp(currentDate: self.selectedDate, completionDate: { date in
            self.selectedDate = date
//            print(date!.toString(dateFormat: AppDateFormat.ddMMYYYY))
            self.tfInput.text = date?.toString(dateFormat: AppDateFormat.ddMMYYYYTransaction)
        })
    }
}
