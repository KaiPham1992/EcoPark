//
//  HomeFilterPopUp.swift
//  EnglishApp
//
//  Created by Ngoc Duong on 10/28/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class HomeFilterPopUp: BasePopUpView {
    
    let vYesNoContentView: HomeFilterPopUpContentView = {
        let view = HomeFilterPopUpContentView()

        return view
    }()
    
    var completionFilter: CompletionAny?
    
    override func setupView() {
        super.setupView()
        vContent.backgroundColor = .clear 
        vContent.addSubview(vYesNoContentView)
        vYesNoContentView.fillSuperview()

        vYesNoContentView.btnNo.addTarget(self, action: #selector(btnNoTapped), for: .touchUpInside)
        vYesNoContentView.btnYes.addTarget(self, action: #selector(btnYesTapped), for: .touchUpInside)
    }
    
    func showPopUp(completionNo: CompletionClosure?, completionFilter: CompletionAny?) {
        self.completionNo = completionNo
        self.completionFilter = completionFilter
        super.showPopUp(height: 300, type: BasePopUpViewType.showFromBottom)
    }
    
    @objc func btnNoTapped() {
        hidePopUp()
        completionNo?()
    }
    
    @objc func btnYesTapped() {
        hidePopUp()
        let distance = vYesNoContentView.distance
        let star = vYesNoContentView.starView.star
        completionFilter?([distance,star])
    }
}
