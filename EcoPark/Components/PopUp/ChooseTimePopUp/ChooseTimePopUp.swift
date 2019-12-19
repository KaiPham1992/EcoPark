//
//  ChooseTimePopUp.swift
//  EcoPark
//
//  Created by Henry on 11/7/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class ChooseTimePopUp: BasePopUpView {
    static let shared = ChooseTimePopUp()
    
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
    
    let timePicker: UIDatePicker = {
        let date = UIDatePicker()
        date.datePickerMode = UIDatePicker.Mode.time
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
    
    var completionTime: CompletionAny?
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(vTop)
        vTop.addSubview(btnDone)
        vTop.addSubview(btnClear)
        
        //---
        vContent.addSubview(vBottom)
        vBottom.addSubview(timePicker)
        
        vTop.anchor(vContent.topAnchor, left: vContent.leftAnchor, bottom: nil, right: vContent.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 41)
        
        btnDone.rightAnchor.constraint(equalTo: vTop.rightAnchor, constant: -20).isActive = true
        btnDone.centerYToSuperview()
        
        vBottom.anchor(vTop.bottomAnchor, left: vTop.leftAnchor, bottom: vContent.bottomAnchor, right: vTop.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        btnClear.centerYToView(view: btnDone, constant: 0)
        btnClear.anchor(right: btnDone.leftAnchor, rightConstant: 20)
        
        timePicker.fillSuperview()
    }
    
    override func btnOverTapped() {
        self.hidePopUp()
        completionNo?()
    }
    
    @objc func btnDoneTapped() {
        self.hidePopUp()
        let timeSelected = timePicker.date
//        let formatter = DateFormatter()
//        formatter.timeStyle = .medium
//        let time = formatter.string(from: timeSelected)
//        let time = timeSelected.toString(dateFormat: AppDateFormat.hhmmss)
        completionTime?(timeSelected)
    }
    
    @objc func btnClearTapped() {
        self.hidePopUp()
        completionTime?(nil)
    }
    
    func showPopUp(completionTime: @escaping CompletionAny) {
        self.completionTime = completionTime

        self.showPopUp(height: 250, type: .showFromBottom)
    }
    
    
    
//    func showPopUp(currentTime: TimeZone? = nil) {
//
//        if currentTime != nil {
//            self.timePicker.settime
//        }
//
//        showPopUp(height: 250, type: .showFromBottom)
//    }
    
    
    
//    func showPopUp(minDate: Date? = nil, maxDate: Date? = nil, currentDate: Date? = nil, completionDate: @escaping CompletionAny) {
//        self.completionTime = completionDate
//
//           if currentDate != nil {
//                 self.timePicker.date = currentDate!
//             }
//             self.timePicker.minimumDate = minDate
//             self.timePicker.maximumDate = maxDate
//
//
//             if currentDate != nil {
//                 self.timePicker.setDate(currentDate!, animated: true)
//             }
//
//             showPopUp(height: 250, type: .showFromBottom)
//    }
//
//    func showPopUp(minDate: Date? = nil, maxDate: Date? = nil, currentDate: Date? = nil, completionDate: @escaping CompletionAny, completionHide:  @escaping CompletionClosure) {
//        self.completionDate = completionDate
//        self.completionNo = completionHide
//
//        self.showPopUp(minDate: minDate, maxDate: maxDate, currentDate: currentDate)
//    }
    
    
}
