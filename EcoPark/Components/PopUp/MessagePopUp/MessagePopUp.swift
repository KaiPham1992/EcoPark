//
//  MessagePopUp.swift
//  EcoPark
//
//  Created by Henry Tran on 11/14/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class MessagePopUp: BasePopUpView {
    
    let viewPopUp: MessagePopUpContent = {
        let view = MessagePopUpContent()
        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(viewPopUp)
        viewPopUp.fillSuperview()

        viewPopUp.btnOk.addTarget(self, action: #selector(btnPopUpTapped), for: .touchUpInside)
    }
    
    func showPopUp(message: String, width: CGFloat, height: CGFloat,  completion: CompletionClosure?) {
        
        viewPopUp.lbContent.text = message
        viewPopUp.btnOk.setTitle(LocalizableKey.ok.showLanguage, for: .normal)
        
        self.completionYes = completion
        super.showPopUp(width: width, height: height)
    }
    
    @objc func btnPopUpTapped() {
        hidePopUp()
    }
}
