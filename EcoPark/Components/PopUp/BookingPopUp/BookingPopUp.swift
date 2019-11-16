//
//  YesNoPopUp.swift
//  Ipos
//
//  Created by Kai Pham on 4/19/19.
//  Copyright © 2019 edward. All rights reserved.
//

import UIKit

class BookingPopUp: BasePopUpView {
    
    let vYesNoContentView: BookingPopUpContent = {
        let view = BookingPopUpContent()

        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(vYesNoContentView)
        vYesNoContentView.fillSuperview()

        vYesNoContentView.btnDetail.addTarget(self, action: #selector(btnDetailTapped), for: .touchUpInside)
        vYesNoContentView.btnDirection.addTarget(self, action: #selector(btnDirectionTapped), for: .touchUpInside)
    }
    
    func showPopUp(width: CGFloat, address: String, message: String, completionDirection: CompletionClosure?, completionDetail: CompletionClosure?) {
        
        let attr1 = LocalizableKey.bookingPopUpAttr1.showLanguage.toAttributedString(color: AppColor.white, font: AppFont.fontRegular15, isUnderLine: false)
        
        let attr2 = "\(message) \(LocalizableKey.bookingPopUpAttr2.showLanguage)".description.toAttributedString(color: AppColor.color_0_129_255, font: AppFont.fontBold15, isUnderLine: false)
        
        let attr3 = LocalizableKey.bookingPopUpAttr3.showLanguage.toAttributedString(color: AppColor.color_102_102_102, font: AppFont.fontRegular15, isUnderLine: false)
        
        let attr = NSMutableAttributedString()
        attr.append(attr1)
        attr.append(attr2)
        attr.append(attr3)
        
        vYesNoContentView.lbAddress.text = address
        
        vYesNoContentView.lbMessage.attributedText = attr
        
        self.completionNo = completionDetail
        self.completionYes = completionDirection
        
        super.showPopUp(width: width, height: 320)
    }
    
    @objc func btnDetailTapped() {
        hidePopUp()
        completionNo?()
    }
    
    @objc func btnDirectionTapped() {
        hidePopUp()
        completionYes?()
    }
}
