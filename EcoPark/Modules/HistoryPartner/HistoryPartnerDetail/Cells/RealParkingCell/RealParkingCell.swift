//
//  RealParkingCell.swift
//  EcoPark
//
//  Created by Steve on 11/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class RealParkingCell: UITableViewCell {
    @IBOutlet weak var DLVRealRevenue: DoubleLabelView!
    @IBOutlet weak var DLVInterstParking: DoubleLabelView!
    @IBOutlet weak var DLVPaymentBag: DoubleLabelView!
    @IBOutlet weak var DLVPaymentMoney: DoubleLabelView!
    @IBOutlet weak var DLVChangeMoney: DoubleLabelView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        DLVRealRevenue.setupViewTimeBlue(title: "Thực thu của bãi")
        DLVInterstParking.setupViewTimeBlue(title: "Hoa hồng EcoParking:")
        DLVPaymentBag.setupViewTimeBlue(title: "KH thanh toán ví:")
        DLVPaymentMoney.setupViewTimeBlue(title: "KH thanh toán tiền mặt:")
        DLVChangeMoney.setupViewTimeBlue(title: "Thay đổi ví tiền:")
    }
}
