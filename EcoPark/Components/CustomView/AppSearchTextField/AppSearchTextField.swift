//
//  AppSearchBar.swift
//  Ipos
//
//  Created by Kai Pham on 5/6/19.
//  Copyright © 2019 edward. All rights reserved.
//

import UIKit

class AppSearchBar: BaseViewXib {
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var vContain: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    var actionSearch : ((String) -> ())?
    var tapToTextField: CompletionClosure?
    
    func setTitleAndPlaceHolder(icon: UIImage? = nil, placeHolder: String? = nil) {
        if placeHolder != nil {
            self.tfInput.placeholder = placeHolder
        }
        
        if icon != nil {
            self.btnSearch.setImage(icon, for: .normal)
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        tfInput.delegate = self
        
        tfInput.addTarget(self, action: #selector(textFieldTapped), for: UIControl.Event.editingDidBegin)
    }
    
    @objc func textFieldTapped() {
        tapToTextField?()
    }
    
    @IBAction func btnSearchTapped() {
        actionSearch?(tfInput.text ?? "")
    }
}

extension AppSearchBar: UITextFieldDelegate {
   

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        actionSearch?(tfInput.text ?? "")
        textField.resignFirstResponder()
        return true
    }
}
