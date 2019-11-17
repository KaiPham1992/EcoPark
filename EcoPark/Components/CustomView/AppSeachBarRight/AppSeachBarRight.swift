//
//  AppSearchBar.swift
//  Ipos
//
//  Created by Kai Pham on 5/6/19.
//  Copyright © 2019 edward. All rights reserved.
//

import UIKit

class AppSeachBarRight: BaseViewXib {
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var vContain: UIView!
    @IBOutlet weak var btnClear: UIButton!
    var actionSearch : ((String) -> ())?
    
    func setTitleAndPlaceHolder(icon: UIImage? = nil, placeHolder: String? = nil) {
        if placeHolder != nil {
            self.tfInput.placeholder = placeHolder
        }
        
        if icon != nil {
            self.btnClear.setImage(icon, for: .normal)
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        tfInput.delegate = self
        
        tfInput.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
    }
    
    @IBAction func btnClearTapped() {
        tfInput.text?.removeAll()
        actionSearch?("")
    }
}

extension AppSeachBarRight: UITextFieldDelegate {
    @objc func textFieldDidChanged() {
        actionSearch?(tfInput.text ?? "")
    }
}
