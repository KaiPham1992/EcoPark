//
//  ChooseDatePopUp.swift
//  EcoPark
//
//  Created by Henry on 11/5/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class ChooseDatePopUp: BasePopUpView {
    static let shared = ChooseDatePopUp()
    
    let vTop: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.f1f1f1
        
        return view
    }()
    
    let vBottom: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.d5d5d5Color
        
        return view
    }()
    
    let datePicker: UIDatePicker = {
        let date = UIDatePicker()
        date.datePickerMode = UIDatePicker.Mode.date
        date.setValue(UIColor.black, forKey: "textColor")
        
        return date
    }()
    
    let btnDone: UIButton = {
        let btn = UIButton()
        btn.setAttributed(title: "Done", color: AppColor.color_0_129_255, font: AppFont.fontRegular15)
        btn.addTarget(self, action: #selector(btnDoneTapped), for: .touchUpInside)
        
        return btn
    }()
    
    let btnClear: UIButton = {
        let btn = UIButton()
        btn.setAttributed(title: "Clear", color: AppColor.gray999999, font: AppFont.fontRegular15)
        btn.addTarget(self, action: #selector(btnClearTapped), for: .touchUpInside)
        
        return btn
    }()
    
    var completionDate: CompletionAny?
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(vTop)
        vTop.addSubview(btnDone)
        vTop.addSubview(btnClear)
        
        //---
        vContent.addSubview(vBottom)
        vBottom.addSubview(datePicker)
        
        vTop.anchor(vContent.topAnchor, left: vContent.leftAnchor, bottom: nil, right: vContent.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 41)
        
        btnDone.rightAnchor.constraint(equalTo: vTop.rightAnchor, constant: -20).isActive = true
        btnDone.centerYToSuperview()
        
        vBottom.anchor(vTop.bottomAnchor, left: vTop.leftAnchor, bottom: vContent.bottomAnchor, right: vTop.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        btnClear.centerYToView(view: btnDone, constant: 0)
        btnClear.anchor(right: btnDone.leftAnchor, rightConstant: 20)
        
        datePicker.fillSuperview()
    }
    
    func showPopUp(minDate: Date? = nil, maxDate: Date? = nil, currentDate: Date? = nil) {
        
//        var min =  Date()
        if currentDate != nil {
            self.datePicker.date = currentDate!
        }
        self.datePicker.minimumDate = minDate
        self.datePicker.maximumDate = maxDate
        
        
        if currentDate != nil {
            self.datePicker.setDate(currentDate!, animated: true)
        }
        
        showPopUp(height: 250, type: .showFromBottom)
    }
    
    override func btnOverTapped() {
        self.hidePopUp()
        completionNo?()
    }
    
    func showPopUp(minDate: Date? = nil, maxDate: Date? = nil, currentDate: Date? = nil, completionDate: @escaping CompletionAny) {
        self.completionDate = completionDate
        
        self.showPopUp(minDate: minDate, maxDate: maxDate, currentDate: currentDate)
    }
    
    func showPopUp(minDate: Date? = nil, maxDate: Date? = nil, currentDate: Date? = nil, completionDate: @escaping CompletionAny, completionHide:  @escaping CompletionClosure) {
        self.completionDate = completionDate
        self.completionNo = completionHide
        
        self.showPopUp(minDate: minDate, maxDate: maxDate, currentDate: currentDate)
    }
    
    @objc func btnDoneTapped() {
        self.hidePopUp()
        let dateSelected = datePicker.date
        completionDate?(dateSelected)
    }
    
    @objc func btnClearTapped() {
        self.hidePopUp()
        completionDate?(nil)
    }
}
