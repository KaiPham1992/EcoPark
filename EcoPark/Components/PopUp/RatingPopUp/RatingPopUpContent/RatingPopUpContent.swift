//
//  RatingPopUpContent.swift
//  EcoPark
//
//  Created by Henry on 11/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import Cosmos
class RatingPopUpContent: BaseViewXib {
    @IBOutlet weak var ratingBar: CosmosView!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    
    override func setUpViews() {
        
        let attr1 = "Dịch vụ bạn đặt đã hoàn thành. Cảm ơn bạn đã tin tưởng sử dụng dịch vụ của ".toAttributedString(color: AppColor.black, font: AppFont.fontRegular15, isUnderLine: false)
        
        let attr2 = "ECOPARKING".description.toAttributedString(color: AppColor.color_0_129_255, font: AppFont.fontBold15, isUnderLine: false)
        
        let attr3 = ". Bạn có hài lòng với dịch vụ của bãi xe?".toAttributedString(color: AppColor.black, font: AppFont.fontRegular15, isUnderLine: false)
        
        let attr = NSMutableAttributedString()
        attr.append(attr1)
        attr.append(attr2)
        attr.append(attr3)
        
        lbContent.attributedText = attr
    }
}
