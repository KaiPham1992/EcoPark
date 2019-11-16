//
//  HeaderInfoView.swift
//  EcoPark
//
//  Created by Tu DV on 11/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: class {
   func toggleSection(header: HeaderInfoView, section: Int)
}

class HeaderInfoView: BaseViewXib {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    
    weak var delegate: HeaderViewDelegate?
    var section: Int = 0
    
    
    override func setUpViews() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }

    func setupUI(title: String) {
        lbTitle.text = title
    }
    
    @objc private func didTapHeader() {
        delegate?.toggleSection(header: self, section: section)
    }
    
    func setExpland(expland: Bool) {
        imgArrow.image = expland ? UIImage(named: "ic_arrow_down") : UIImage(named: "ic_arrow_right")
    }
}
