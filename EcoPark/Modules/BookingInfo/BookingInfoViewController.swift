//
//  BookingInfoViewController.swift
//  EnglishApp
//
//  Created Ngoc Duong on 10/29/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class BookingInfoViewController: BaseViewController, BookingInfoViewProtocol {
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var ratingBar: AppRatingView!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbCapacity: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbPriceOneHour: UILabel!
    @IBOutlet weak var lbPriceEightHour: UILabel!
    @IBOutlet weak var lbPriceToHoldPlace: UILabel!
    @IBOutlet weak var datePicker: DatePicker!
    @IBOutlet weak var timePicker: TimePicker!
    @IBOutlet weak var btnBook: UIButton!
    @IBOutlet weak var lbPlate: UILabel!
    @IBOutlet weak var dropDownType: AppDropDownNoTitle!
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTitleBookingInfo: UILabel!
    @IBOutlet weak var lbTitleOne: UILabel!
    @IBOutlet weak var lbTitleEight: UILabel!
    @IBOutlet weak var lbTitlePriceHoldPlace: UILabel!
    
    @IBOutlet weak var lbTitleDate: UIButton!
    @IBOutlet weak var lbTitleTime: UIButton!
    @IBOutlet weak var lbTitlePlate: UIButton!
    @IBOutlet weak var lbTitleType: UIButton!
    
	var presenter: BookingInfoPresenterProtocol?
    var parking: ParkingEntity?

	override func viewDidLoad() {
        super.viewDidLoad()
        
        getParkingInfo()
        getVehicleType()
    }
    
    func getParkingInfo() {
        if let id = parking?.parking_id {
            self.presenter?.getParkingInfo(id: id)
        }
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.titleBookingInfo.showLanguage)
    }
    
    override func setUpViews() {
        super.setUpViews()
        
        lbTitle.text = LocalizableKey.keepPlace.showLanguage
        lbCapacity.text = LocalizableKey.maxCapacity.showLanguage
        lbTime.text = LocalizableKey.parkingTime.showLanguage
        lbTitleOne.text = LocalizableKey.parkingFee.showLanguage
        lbTitleEight.text = LocalizableKey.parkingFeeCombo.showLanguage
        lbTitleBookingInfo.text = LocalizableKey.bookingInfo.showLanguage
        
        lbTitleDate.setTitle(LocalizableKey.date.showLanguage, for: .normal)
        lbTitleTime.setTitle(LocalizableKey.timeToCome.showLanguage, for: .normal)
        lbTitlePlate.setTitle(LocalizableKey.vehiclePlate.showLanguage, for: .normal)
        lbTitleType.setTitle(LocalizableKey.vehicleType.showLanguage, for: .normal)
        
        lbPriceToHoldPlace.text = LocalizableKey.feeKeepPlace.showLanguage
        btnBook.setTitle(LocalizableKey.payToKeepPlace.showLanguage, for: .normal)
        dropDownType.setPlaceHolder(placeHolder: LocalizableKey.vehicleType.showLanguage)
    }
    
    func displayData(info: ParkingInfoEntity) {
        lbName.text = info.name
        if let rate = info.rating {
            ratingBar.setStar(number: rate)
        }
        lbType.text = info.parking_type
        lbCapacity.text = LocalizableKey.maxCapacity.showLanguage + info.number_place& + " " + LocalizableKey.place.showLanguage
        
        if let timeStart = info.time_start?.toString(dateFormat: .HHmm),
            let timeEnd = info.time_end?.toString(dateFormat: .HHmm) {
            
            let attr = NSMutableAttributedString()
            let attr1 = "\(LocalizableKey.parkingTime.showLanguage)".toAttributedString(color: AppColor.color_102_102_102)
            let attr2 = "\(timeStart) - \(timeEnd)".toAttributedString(color: AppColor.color_13_196_68, font: AppFont.fontRegular15, isUnderLine: false)
            attr.append(attr1)
            attr.append(attr2)
            lbTime.attributedText = attr
        }
        if let price = info.price {
            lbPriceOneHour.text = price.toCurrency + LocalizableKey.eachHours.showLanguage
        }
        if let packagePrice = info.package_price {
            lbPriceEightHour.text = packagePrice.toCurrency + LocalizableKey.eachPackage.showLanguage
        }
        lbPlate.text = "Don't know"
        lbPriceToHoldPlace.text = "Don't know"
    }
    
    @IBAction func btnBookingTapped() {
        booking()
    }
    
    // MARK: Get error
    func didGetError(error: APIError) {
        printError(message: error.message)
    }
    
    // MARK: Book reservation
    func booking() {
        guard let parkId = parking?.parking_id,
            let vehicleId = (dropDownType.selectedItem as? VehicleTypeEntity)?.id else { return }
        
        let time = datePicker.date& + " " + timePicker.time&
        let plate = "59F2-123.45"
        let moneyPaid = "1000"
        presenter?.booking(time: time, parkId: parkId, vehicleId: vehicleId, plate: plate, moneyPaid: moneyPaid)
    }
    func didBooking(info: BookingEntity) {
        let pop = BookingPopUp()
        pop.showPopUp(address: "Address", message: "10", completionDirection: {
            print("Direction")
        }) {
            print("Detail")
        }
    }
    
    // MARK: Get vehicle type
    func getVehicleType() {
        self.presenter?.getVehicleType()
    }
    
    func didGetVehicleType(listVehicle: [VehicleTypeEntity]) {
        dropDownType.listItem = listVehicle
        dropDownType.selectedItem = listVehicle.first
    }
    
    // MARK: Get Park Info
    func getParkingDetail() {
        if let id = parking?.parking_id {
            self.presenter?.getParkingInfo(id: id)
        }
    }
    func didGetInfo(info: ParkingInfoEntity) {
        displayData(info: info)
    }

}
