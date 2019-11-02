//
//  PaymentPopUp.swift
//  EcoPark
//
//  Created by Henry on 11/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
class PaymentPopUp: BasePopUpView {
    
    let viewPopUp: PaymentPopUpContent = {
        let view = PaymentPopUpContent()
        view.line.layer.masksToBounds = false
        view.line.layer.shadowColor = UIColor.black.cgColor
        view.line.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        view.line.layer.shadowOpacity = 0.8
        view.line.layer.shadowRadius = 4.0
        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(viewPopUp)
        viewPopUp.fillSuperview()

        viewPopUp.btnPay.addTarget(self, action: #selector(btnPayTapped), for: .touchUpInside)
    }
    
    func showPopUp(ecoMoney: Int, cashMoney: Int, needToPay: Int, width: CGFloat, height: CGFloat, completionPay: CompletionClosure?) {
        
        viewPopUp.lbEcoAccount.text = ecoMoney.description.formatNumber(type: ",")
        viewPopUp.lbCash.text = cashMoney.description.formatNumber(type: ",")
        viewPopUp.lbNeedToPay.text = needToPay.description.formatNumber(type: ",")
        
        self.completionYes = completionPay
        super.showPopUp(width: width, height: height)
    }
    
    @objc func btnPayTapped() {
        hidePopUp()
        completionYes?()
    }
}
