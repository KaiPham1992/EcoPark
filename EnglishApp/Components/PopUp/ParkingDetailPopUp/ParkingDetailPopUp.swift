//
//  YesNoPopUp.swift
//  Ipos
//
//  Created by Kai Pham on 4/19/19.
//  Copyright © 2019 edward. All rights reserved.
//

import UIKit

class ParkingDetailPopUp: BasePopUpView {
    
    let vYesNoContentView: ParkingDetailContent = {
        let view = ParkingDetailContent()

        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(vYesNoContentView)
        vYesNoContentView.fillSuperview()

        vYesNoContentView.btnNo.addTarget(self, action: #selector(btnNoTapped), for: .touchUpInside)
        vYesNoContentView.btnYes.addTarget(self, action: #selector(btnYesTapped), for: .touchUpInside)
    }
    
    func showPopUp(money: Int, completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        
        let attr1 = "Bạn sẽ bị trừ ".toAttributedString(color: AppColor.color_102_102_102, font: AppFont.fontRegular15, isUnderLine: false)
        
        let attr2 = money.description.toAttributedString(color: AppColor.color_0_129_255, font: AppFont.fontBold15, isUnderLine: false)
        
        let attr3 = " vào tài khoản ví để xem thông tin chi tiết bãi đổ bao gồm địa chỉ và thông tin liên hệ của bãi đó.".toAttributedString(color: AppColor.color_102_102_102, font: AppFont.fontRegular15, isUnderLine: false)
        
        let attr = NSMutableAttributedString()
        attr.append(attr1)
        attr.append(attr2)
        attr.append(attr3)
        
        vYesNoContentView.lbMessage.attributedText = attr
        
        self.completionNo = completionNo
        self.completionYes = completionYes
        
        super.showPopUp(height: 216)
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
