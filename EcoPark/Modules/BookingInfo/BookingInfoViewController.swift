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
import MapKit

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
    @IBOutlet weak var tfPlate: UITextField!
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
        
        lbTitleDate.setTitle("  \(LocalizableKey.date.showLanguage)*", for: .normal)
        lbTitleTime.setTitle("  \(LocalizableKey.timeToCome.showLanguage)*", for: .normal)
        lbTitlePlate.setTitle("  \(LocalizableKey.vehiclePlate.showLanguage)*", for: .normal)
        lbTitleType.setTitle("  \(LocalizableKey.vehicleType.showLanguage)*", for: .normal)
        
        lbPriceToHoldPlace.text = LocalizableKey.feeKeepPlace.showLanguage
        btnBook.setTitle(LocalizableKey.payToKeepPlace.showLanguage, for: .normal)
        dropDownType.setPlaceHolder(placeHolder: LocalizableKey.vehicleType.showLanguage)
        tfPlate.placeholder = LocalizableKey.vehiclePlate.showLanguage
        lbTitlePriceHoldPlace.text = LocalizableKey.feeKeepPlace.showLanguage
    }
    
    func displayData(info: ParkingInfoEntity) {
        lbName.text = info.name
        if let rate = info.rating {
            ratingBar.setStar(number: rate)
            ratingBar.setTitle(number: info.total_rating&)
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
            lbPriceToHoldPlace.text = price.toCurrency
        }
        if let packagePrice = info.package_price {
            lbPriceEightHour.text = packagePrice.toCurrency + LocalizableKey.eachPackage.showLanguage
        }
    }
    
    @IBAction func btnBookingTapped() {
        if let wallet = UserDefaultHelper.shared.loginUserInfo?.wallet, let price = parking?.price, wallet > price {
            booking()
        } else {
            PopUpHelper.shared.showMessage(message: "Bạn không đủ tiền trong ví", width: popUpwidth) {
                
            }
        }
        
    }
    
    // MARK: Get error
    func didGetError(error: APIError) {
        printError(message: error.message)
    }
    
    // MARK: Book reservation
    func booking() {
        
        print(timePicker.date)
        
        
        do {
            _ = try datePicker.tfDate.text?.validate(validatorType: .requiredField(message: "Bạn chưa chọn ngày"))
            _ = try timePicker.tfTime.text?.validate(validatorType: .requiredField(message: "Bạn chưa chọn giờ đến bãi"))
            let plate = try tfPlate.text?.validate(validatorType: .requiredField(message: "Bạn chưa nhập biển số")) ?? ""
            _ = try dropDownType.tfInput.text?.validate(validatorType: .requiredField(message: "Bạn chưa chọn loại xe"))
            guard let dateTime = timePicker.date else { return }
            if datePicker.dateSelected?.isToday == true  {
                if dateTime < Date() {
                    PopUpHelper.shared.showMessage(message: "Giờ < giờ hiện tại", width: popUpwidth, completion: {})
                    return
                }
            }
            
            //---
            guard let parkId = parking?.parking_id,
            let vehicleId = (dropDownType.selectedItem as? VehicleTypeEntity)?.id,
            let moneyPaid = parking?.price else { return }
            let hhmm = timePicker.date?.toString(dateFormat: AppDateFormat.hhmmss)&
            let time = datePicker.date& + " " + hhmm&
                        
            presenter?.booking(time: time, parkId: parkId, vehicleId: vehicleId, plate: plate, moneyPaid: moneyPaid.description)
            
        } catch {
            guard let error = error as? InvalidError else { return }
            PopUpHelper.shared.showMessage(message: error.message, width: popUpwidth) {
                
            }
        }
    }
    
    func didBooking(info: BookingEntity) {
        guard let address = parking?.address else { return }
        let pop = BookingPopUp()
        
        pop.showPopUp(width: popUpwidth, address: address, message: "1", completionDirection: {
            guard let lat = self.parking?.lat, let long = self.parking?.long else { return }
            self.navigationController?.popToRootViewController(animated: true)
            self.openGoogleMapForPlace(lat: lat, long: long)
        }) {
            guard let bookingId = info.id else { return }
            let bookingParking = HistoryBookingParkingResponse()
            bookingParking.id = bookingId
            let vc = DetailParkingRouter.createModule(bookingParking: bookingParking)
            self.push(controller: vc)
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

extension BookingInfoViewController {
    func openAppleMapForPlace(lat: Double, long: Double) {
        let latitude: CLLocationDegrees =  lat
        let longitude: CLLocationDegrees =  long

        let regionDistance: CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.parking?.parking_name
        mapItem.openInMaps(launchOptions: options)

    }
    
    func openGoogleMapForPlace(lat: Double, long: Double) {
        let lat = lat
        let long = long

        let customURL = "comgooglemaps://"
        let urlRoute = "comgooglemaps://?saddr=&daddr=\(lat),\(long)&directionsmode=driving"
        if UIApplication.shared.canOpenURL(NSURL(string: customURL)! as URL) {
            UIApplication.shared.open(NSURL(string: urlRoute)! as URL, options: [:], completionHandler: nil)
        } else {
            openAppleMapForPlace(lat: lat, long: long)
        }
    }
}
