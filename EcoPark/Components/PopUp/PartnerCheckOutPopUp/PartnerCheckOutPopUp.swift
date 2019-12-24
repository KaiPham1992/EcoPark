//
//  PartnerCheckOutPopUp.swift
//  EcoPark
//
//  Created by Henry on 11/4/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
class PartnerCheckOutPopUp: BasePopUpView {
    let viewPopUp: PartnerCheckOutPopUpContent = {
        let view = PartnerCheckOutPopUpContent()
        return view
    }()

    var completionCheck: CompletionClosure?
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(viewPopUp)
        viewPopUp.fillSuperview()

        viewPopUp.btnCancel.addTarget(self, action: #selector(btnCancelTapped), for: .touchUpInside)
        viewPopUp.btnCheckOut.addTarget(self, action: #selector(btnCheckOutTapped), for: .touchUpInside)
        viewPopUp.btnCheckAgain.addTarget(self, action: #selector(btnCheckAgainTapped), for: .touchUpInside)
    }
    
    func showPopUp(width: CGFloat, height: CGFloat, price: Double, vehicleType: String, vehicleNumber: String, checkOutNumber: String, completionCancel: CompletionClosure?, completionCheckAgain: CompletionClosure?, completionCheckout: CompletionClosure?) {
        viewPopUp.lbPrice.text = price.description.formatNumber(type: ",")
        viewPopUp.lbVehicleType.text = vehicleType
        viewPopUp.lbVehicleNumber.text = vehicleNumber
        
        
        let attr1 = LocalizableKey.contentCheckout.showLanguage.toAttributedString(color: AppColor.black, font: AppFont.fontRegular15, isUnderLine: false)
        let attr2 = " \(checkOutNumber)".description.toAttributedString(color: AppColor.black, font: AppFont.fontBold15, isUnderLine: false)
                
        let attr = NSMutableAttributedString()
        attr.append(attr1)
        attr.append(attr2)
        
        self.completionNo = completionCancel
        self.completionYes = completionCheckout
        self.completionCheck = completionCheckAgain
        
        viewPopUp.lbContent.attributedText = attr
        super.showPopUp(width: width, height: height)
    }
    
    @objc func btnCancelTapped() {
        hidePopUp()
        completionNo?()
    }
    
    @objc func btnCheckOutTapped() {
        hidePopUp()
        completionYes?()
    }
    
    @objc func btnCheckAgainTapped() {
        hidePopUp()
        completionCheck?()
    }
}
