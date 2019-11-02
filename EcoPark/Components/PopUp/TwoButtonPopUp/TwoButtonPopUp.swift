//
//  TwoButtonPopUp.swift
//  EcoPark
//
//  Created by Henry on 11/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
class TwoButtonPopUp: BasePopUpView {
    
    let viewPopUp: TwoButtonPopUpContent = {
        let view = TwoButtonPopUpContent()
        return view
    }()

    override func setupView() {
        super.setupView()
        
        vContent.addSubview(viewPopUp)
        viewPopUp.fillSuperview()

        viewPopUp.btnNo.addTarget(self, action: #selector(btnNoTapped), for: .touchUpInside)
        viewPopUp.btnYes.addTarget(self, action: #selector(btnYesTapped), for: .touchUpInside)
    }
    
    func showPopUp(titlePopUp: String, contentPopUpNormal: String, btnTitleNo: String, btnTitleYes: String, width: CGFloat, height: CGFloat, completionYes: CompletionClosure?, completionNo: CompletionClosure?) {
        
        viewPopUp.lbTitlePopUp.text = titlePopUp
        viewPopUp.lbContentPopUp.text = contentPopUpNormal
        
        viewPopUp.btnNo.setTitle(btnTitleNo, for: .normal)
        viewPopUp.btnYes.setTitle(btnTitleYes, for: .normal)
        
        self.completionYes = completionYes
        self.completionNo = completionNo
        
        super.showPopUp(width: width, height: height)
    }
    
    @objc func btnNoTapped() {
        hidePopUp()
        completionNo?()
    }
    
    @objc func btnYesTapped() {
        hidePopUp()
        completionYes?()
    }
}
