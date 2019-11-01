//
//  OneButtonPopUp.swift
//  EcoPark
//
//  Created by Henry on 11/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class OneButtonPopUp: BasePopUpView {
    
    let viewPopUp: OneButtonPopUpContent = {
        let view = OneButtonPopUpContent()
        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(viewPopUp)
        viewPopUp.fillSuperview()

        viewPopUp.btnPopUp.addTarget(self, action: #selector(btnPopUpTapped), for: .touchUpInside)
    }
    
    func showPopUp(titlePopUp: String, contentPopUpAtributedString: NSAttributedString, buttonTitle: String, width: CGFloat, height: CGFloat, completion: CompletionClosure?){
        
        viewPopUp.lbTitlePopUp.text = titlePopUp.uppercased()
        viewPopUp.lbContentPopUp.attributedText = contentPopUpAtributedString
        viewPopUp.btnPopUp.setTitle(buttonTitle, for: .normal)
        
        self.completionYes = completion
        super.showPopUp(width: width, height: height)
    }
    
    func showPopUp(titlePopUp: String, contentPopUpNormal: String, buttonTitle: String, width: CGFloat, height: CGFloat,  completion: CompletionClosure?){
        
        viewPopUp.lbTitlePopUp.text = titlePopUp.uppercased()
        viewPopUp.lbContentPopUp.text = contentPopUpNormal
        viewPopUp.btnPopUp.setTitle(buttonTitle, for: .normal)
        
        self.completionYes = completion
        super.showPopUp(width: width, height: height)
    }
    
    @objc func btnPopUpTapped(){
        hidePopUp()
        completionYes?()
    }
}
