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
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(viewPopUp)
        viewPopUp.fillSuperview()
        viewPopUp.btn4.tag = 1992
        viewPopUp.btn4.addTarget(self, action: #selector(btnPopUpTapped), for: .touchUpInside)
        
        viewPopUp.btn7.addTarget(self, action: #selector(btnPopUpTapped), for: .touchUpInside)
    }
    
    func showPopUp(listVehical: [VehicleTypeEntity]) {
        
    }
    
    @objc func btnPopUpTapped(sender: UIButton) {
        hidePopUp()
    }
}
