//
//  DetailParkingViewController.swift
//  EcoPark
//
//  Created Steve on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class DetailParkingViewController: BaseViewController, DetailParkingViewProtocol {

	var presenter: DetailParkingPresenterProtocol?
    
    @IBOutlet weak var viewRate: UIView!
    @IBOutlet weak var DLVInformationParking: DoubleLabelView!
    @IBOutlet weak var ILVContactParking: ImageLabelView!
    @IBOutlet weak var ILVPointRoad: ImageLabelView!
    @IBOutlet weak var VTDate: TimeView!
    @IBOutlet weak var VTHour: TimeView!
    @IBOutlet weak var VTMinute: TimeView!
    @IBOutlet weak var DLVBook: DoubleLabelView!
    @IBOutlet weak var DLVExpected: DoubleLabelView!
    @IBOutlet weak var DLVCheckIn: DoubleLabelView!
    @IBOutlet weak var DLVCheckOut: DoubleLabelView!
    @IBOutlet weak var DLVLisencePlate: DoubleLabelView!
    @IBOutlet weak var DLVBillForHour: DoubleLabelView!
    @IBOutlet weak var DLVBillFor8Hour: DoubleLabelView!
    @IBOutlet weak var DLVNumberParking: DoubleLabelView!
    @IBOutlet weak var DLVMoneyPayment: DoubleLabelView!
    @IBOutlet weak var DLVPriceParking: DoubleLabelView!
    @IBOutlet weak var DLVAddForWallet: DoubleLabelView!
    @IBOutlet weak var DLVAddForMoney: DoubleLabelView!
    @IBOutlet weak var btnBottom: UIButton!
    var type : TypeDetailParking = .checkin
    
    override func setUpViews() {
        super.setUpViews()
        if type == .complete {
            viewRate.isHidden = false
            btnBottom.isHidden = true
        } else {
            btnBottom.isHidden = false
            if type == .checkin {
                btnBottom.setTitle("QR Check In", for: .normal)
            } else {
                btnBottom.setTitle("Đánh giá dịch vụ bãi xe", for: .normal)
            }
            viewRate.isHidden = true
        }
        ILVContactParking.initView(image: #imageLiteral(resourceName: "ic_call"), title: "Liên hệ bãi")
        ILVPointRoad.initView(image: #imageLiteral(resourceName: "ic_direction"), title: "Chỉ đường")
        DLVInformationParking.setupViewForTitle(title: "Thông tin bãi đỗ xe")
        VTDate.setupTitle(title: "Ngày")
        VTHour.setupTitle(title: "Giờ")
        VTMinute.setupTitle(title: "Phút")
        DLVBook.setupViewTimeBlue(title: "Đặt lúc")
        DLVExpected.setupViewTimeBlue(title: "Dự kiến")
        DLVCheckIn.setupViewTimeBlue(title: "Check in")
        DLVCheckOut.setupViewTimeBlue(title: "Check out")
        DLVLisencePlate.setupViewTimeBold(title: "Biển số:")
        DLVBillForHour.setupViewUnit(title: "Đơn giá theo giờ:")
        DLVBillFor8Hour.setupViewUnit(title: "Đơn giá gói 8 giờ:")
        DLVNumberParking.setupViewUnit(title: "Số giờ đã gửi:")
        DLVMoneyPayment.setupViewUnit(title: "Phí giữ xe:")
        DLVPriceParking.setupViewUnit(title: "Đã thanh toán:")
        DLVAddForWallet.setupViewUnit(title: "TT thêm bằng ví:")
        DLVAddForMoney.setupViewUnitColorRed(title: "TT thêm bằng tiền mặt:")
        
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        setTitleNavigation(title: "Chi tiết giao dịch")
        addBackToNavigation()
    }
}
