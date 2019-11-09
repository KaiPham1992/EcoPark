//
//  PriceAddMoneyCell.swift
//  EcoPark
//
//  Created by Steve on 11/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class PriceAddMoneyCell: UITableViewCell {
    @IBOutlet weak var DLVBillForHour: DoubleLabelView!
    @IBOutlet weak var DLVBillFor8Hour: DoubleLabelView!
    @IBOutlet weak var DLVNumberParking: DoubleLabelView!
    @IBOutlet weak var DLVMoneyPayment: DoubleLabelView!
    @IBOutlet weak var DLVPriceParking: DoubleLabelView!
    @IBOutlet weak var DLVAddForWallet: DoubleLabelView!
    @IBOutlet weak var DLVAddForMoney: DoubleLabelView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        DLVBillForHour.setupViewUnit(title: "Đơn giá theo giờ:")
        DLVBillFor8Hour.setupViewUnit(title: "Đơn giá gói 8 giờ:")
        DLVNumberParking.setupViewUnit(title: "Số giờ đã gửi:")
        DLVMoneyPayment.setupViewUnit(title: "Phí giữ xe:")
        DLVPriceParking.setupViewUnit(title: "Đã thanh toán:")
        DLVAddForWallet.setupViewUnit(title: "TT thêm bằng ví:")
        DLVAddForMoney.setupViewUnitColorRed(title: "TT thêm bằng tiền mặt:")
    }
}
