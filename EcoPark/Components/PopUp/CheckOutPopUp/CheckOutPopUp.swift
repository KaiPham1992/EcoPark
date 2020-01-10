//
//  CheckOutPopUp.swift
//  EcoPark
//
//  Created by Tu DV on 1/10/20.
//  Copyright © 2020 demo. All rights reserved.
//

import UIKit

class CheckOutPopUp: BasePopUpView {
    let viewPopUp: CheckOutPopUpContent = {
        let view = CheckOutPopUpContent()
        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(viewPopUp)
        viewPopUp.fillSuperview()

        viewPopUp.btnCheckOut.addTarget(self, action: #selector(btnCheckOutTapped), for: .touchUpInside)
        viewPopUp.btnCancel.addTarget(self, action: #selector(btnCancleTapped), for: .touchUpInside)
        
    }
    
    func showPopUp(name: String, licensePlate: String, time: String, timeOut: String, width: CGFloat, height: CGFloat, completionYes: CompletionClosure?, completionNo: CompletionClosure? ){
        
        viewPopUp.lbName.text = name
        viewPopUp.lbLicensePlate.text = licensePlate
        viewPopUp.lbTime.text = time
        viewPopUp.lbCheckoutTime.text = timeOut
        
        self.completionYes = completionYes
        self.completionNo = completionNo
        
        super.showPopUp(width: width, height: height)
    }
    
    @objc func btnCheckOutTapped(){
        hidePopUp()
        completionYes?()
    }
    
    @objc func btnCancleTapped(){
        hidePopUp()
        completionNo?()
    }
}
