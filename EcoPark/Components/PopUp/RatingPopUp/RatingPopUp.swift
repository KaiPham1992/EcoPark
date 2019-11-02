//
//  RatingPopUp.swift
//  EcoPark
//
//  Created by Henry on 11/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
class RatingPopUp: BasePopUpView {
    
    let viewPopUp: RatingPopUpContent = {
        let view = RatingPopUpContent()
        return view
    }()

    var completionRate: CompletionAny?
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(viewPopUp)
        viewPopUp.fillSuperview()

        viewPopUp.btnCancel.addTarget(self, action: #selector(btnCancelTapped), for: .touchUpInside)
        viewPopUp.btnSend.addTarget(self, action: #selector(btnSendTapped), for: .touchUpInside)
    }
    
    func showPopUp(width: CGFloat, height: CGFloat, completionCancel: CompletionClosure?, completionSend: CompletionAny?) {
        
        self.completionNo = completionCancel
        self.completionRate = completionSend
        super.showPopUp(width: width, height: height)
    }
    
    @objc func btnCancelTapped() {
        hidePopUp()
        completionNo?()
    }
    
    @objc func btnSendTapped() {
        hidePopUp()
        completionRate?(viewPopUp.ratingBar.rating)
    }
}
