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
    var completionIndex: CompletionAny?
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
    
    func showPopUp(indexSelect: Int, listVehical: [VehicleTypeEntity], width: CGFloat, completion: @escaping CompletionAny, completionIndex: @escaping CompletionAny) {
        self.showPopUp(width: width, height: 250, type: .zoomOut)
          viewPopUp.isSelectIndex = indexSelect
        viewPopUp.listVehical = listVehical
      
        self.completion = completion
        self.completionIndex = completionIndex
        
    }
    
    @objc func btnPopUpTapped(sender: UIButton) {
        hidePopUp()
        completionIndex?(sender.tag)
        completion?(viewPopUp.listVehical[sender.tag])
    }
}
