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
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnExtend: UIButton!
    @IBOutlet weak var btnBottom: UIButton!
    @IBOutlet weak var heightOfRating: NSLayoutConstraint!
    @IBOutlet weak var heightOfButtonCancel: NSLayoutConstraint!
    @IBOutlet weak var heightOfButtonExtend: NSLayoutConstraint!
    
    @IBOutlet weak var lbBookingNumber: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    
    var type : StatusBooking = .cancel
    var bookingId: String = ""
    
    override func setUpViews() {
        super.setUpViews()
        if type == .cancel, type == .expired {
            viewRate.isHidden = false
            heightOfRating.constant = 0
            heightOfButtonCancel.constant = 0
            heightOfButtonExtend.constant = 0
            btnBottom.isHidden = true
        }
        if type == .checked_out {
           heightOfRating.constant = 0
            heightOfButtonCancel.constant = 50
            heightOfButtonExtend.constant = 50
            btnBottom.isHidden = false
            btnBottom.setTitle("Đánh giá dịch vụ bãi xe", for: .normal)
            viewRate.isHidden = true
        }
        if type == .checked_in, type == .reservation {
            heightOfRating.constant = 0
            heightOfButtonCancel.constant = 50
            heightOfButtonExtend.constant = 50
            btnBottom.isHidden = false
            btnBottom.setTitle("Scan QR tại bãi để Check In", for: .normal)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBookingDetail()
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        setTitleNavigation(title: "Chi tiết giao dịch")
        addBackToNavigation()
    }
    
    func displayData(info: BookingDetailEntity) {
        lbBookingNumber.text = info.code
        if let timeStart = info.parking_details?.time_start?.toString(dateFormat: .HHmm),
            let timeEnd = info.parking_details?.time_end?.toString(dateFormat: .HHmm) {
            DLVInformationParking.setValueText(text: timeStart + " - " + timeEnd)
        }
        lbName.text = info.parking_details?.name
        lbAddress.text = info.parking_details?.address
        
        if let createTime = info.create_time {
            DLVBook.setValueText(text: createTime.toString(dateFormat: .hhmmddmmyyy))
        }
        if let intendCheck = info.intend_checkin_time {
            DLVExpected.setValueText(text: intendCheck.toString(dateFormat: .hhmmddmmyyy))
        }
        if let checkIn = info.time_check_in?.toString(dateFormat: .hhmmddmmyyy) {
            DLVCheckIn.setValueText(text: checkIn)
        } else {
            DLVCheckIn.setValueText(text: "-")
        }
        if let checkOut = info.time_check_out?.toString(dateFormat: .hhmmddmmyyy) {
            DLVCheckOut.setValueText(text: checkOut)
        } else {
            DLVCheckOut.setValueText(text: "-")
        }
        DLVLisencePlate.setValueText(text: info.license_plates ?? "")
        if let price = info.parking_details?.price {
            DLVBillForHour.setValueText(text: price.toCurrency)
        }
        if let packagePrice = info.parking_details?.package_price {
            DLVBillFor8Hour.setValueText(text: packagePrice.toCurrency)
        }
        DLVNumberParking.setValueText(text: "-")
        DLVMoneyPayment.setValueText(text: "-")
        DLVPriceParking.setValueText(text: "-")
        DLVAddForWallet.setValueText(text: "-")
        DLVAddForMoney.setValueText(text: "-")
        
    }
    
    // MARK: Get booking detail
    func getBookingDetail() {
        if self.bookingId != "" {
            self.presenter?.getBookingDetail(id: self.bookingId)
        }
    }
    
    func didGetBookingDetail(info: BookingDetailEntity) {
        displayData(info: info)
    }
    
    // MARK: Error
    func didGetError(error: APIError) {
        printError(message: error.message)
    }
    

}
