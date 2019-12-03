//
//  CheckInPopUp.swift
//  EcoPark
//
//  Created by Henry on 11/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CheckInPopUp: BasePopUpView {
    
    let viewPopUp: CheckInPopUpContent = {
        let view = CheckInPopUpContent()
        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(viewPopUp)
        viewPopUp.fillSuperview()

        viewPopUp.btnCheckIn.addTarget(self, action: #selector(btnCheckInTapped), for: .touchUpInside)
        viewPopUp.btnCancel.addTarget(self, action: #selector(btnCancleTapped), for: .touchUpInside)
        
    }
    
    func showPopUp(name: String, address: String, time: String, width: CGFloat, height: CGFloat, completionYes: CompletionClosure?, completionNo: CompletionClosure? ){
        
        viewPopUp.lbName.text = name
        viewPopUp.lbAddress.text = address
        viewPopUp.lbTime.text = time
        
        self.completionYes = completionYes
        self.completionNo = completionNo
        
        super.showPopUp(width: width, height: height)
    }
    
    @objc func btnCheckInTapped(){
        hidePopUp()
        completionYes?()
    }
    
    @objc func btnCancleTapped(){
        hidePopUp()
        completionNo?()
    }
}
