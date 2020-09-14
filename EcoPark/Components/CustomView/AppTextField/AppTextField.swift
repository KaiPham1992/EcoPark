//
//  AppTextField.swift
//  Ipos
//
//  Created by Kai Pham on 4/19/19.
//  Copyright © 2019 edward. All rights reserved.
//

import UIKit

class AppTextField: BaseViewXib {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfInput: CustomSecureTextField!
    @IBOutlet weak var vLine: UIView!
    
    var textFieldDidBeginEditing : (() -> Void)?
    var textFieldDidChange : (() -> Void)?
    
    func setTitleAndPlaceHolder(title: String? = nil, placeHolder: String? = nil) {
        if title != nil {
            self.lbTitle.text = title
        }
        
        if placeHolder != nil {
            tfInput.placeholder = placeHolder&
        }
    }
    
    
    func getText() -> String {
        return tfInput.text&
    }
    
    override func setUpViews() {
        super.setUpViews()
        self.tfInput.delegate = self
    }
}

extension AppTextField: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let complete = self.textFieldDidBeginEditing {
            complete()
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let complete = self.textFieldDidChange {
            complete()
        }
    }
}
