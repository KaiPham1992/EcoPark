//
//  SelectCarPopUp.swift
//  EcoPark
//
//  Created by Ngoc Duong on 12/18/19.
//  Copyright © 2019 demo. All rights reserved.
//


import UIKit

class SelectCarPopUp: BasePopUpView {
    
    let viewPopUp: SelectCarPopUpContent = {
        let view = SelectCarPopUpContent()
        
        return view
    }()
    
    var completion: CompletionAny?
    var indexSelect: Int = 0
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(viewPopUp)
        viewPopUp.fillSuperview()
        viewPopUp.btn4.tag = 0
        viewPopUp.btn7.tag = 1
        viewPopUp.btn4.addTarget(self, action: #selector(btnPopUpTapped), for: .touchUpInside)
        viewPopUp.btn7.addTarget(self, action: #selector(btnPopUpTapped), for: .touchUpInside)
    }
    
    func showPopUp(indexSelect: Int, width: CGFloat, completion: @escaping CompletionAny) {
        self.showPopUp(width: width, height: 250, type: .zoomOut)
        viewPopUp.setStyle(indexSelected: indexSelect)
        self.completion = completion
    }
    
    @objc func btnPopUpTapped(sender: UIButton) {
        hidePopUp()
        indexSelect = sender.tag
        completion?(sender.tag)
    }
}
