//
//  PageHistoryPartner.swift
//  EcoPark
//
//  Created by Tu DV on 11/4/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class PageHistoryPartnerViewControler : PageViewController {
    
    var parkedNumber: Int = 0
    var numberPlace: String = "0"
    var bookingReservation: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleNavigation(title: LocalizableKey.titleHistoryParking.showLanguage)
        addButtonImageToNavigation(image: #imageLiteral(resourceName: "ic_menu"), style: StyleNavigation.left, action: #selector(openMenu))
        addButtonImageToNavigation(image: #imageLiteral(resourceName: "ic_qrcheckout"), style: StyleNavigation.right, action: #selector(checkQrCode))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callAPIHistoryPartner()
    }
    
    @objc func openMenu(){
        if let containerController = navigationController?.parent as? ContainerViewController {
            containerController.toggleLeftPanel()
        }
    }
    
    @objc func checkQrCode() {
        let vc = HistoryPartnerQRScannerRouter.createModule(isCheckIn: false)
        vc.completionCode = { code in
            ///call api checkout
            
            guard let qrcode = code as? [String] else { return }
            if qrcode.count > 5 {
                print(qrcode)
                let bookingID = qrcode[2]
                let code = qrcode[4]
                let licensePlates = qrcode[3]
                self.callAPICheckout(bookingID: bookingID, code: code, license_plates: licensePlates)
            }
            
        }
        self.push(controller: vc)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [HistoryPartnerHoldingRouter.createModule(numberPlace: numberPlace, parkedNumber: parkedNumber), HistoryPartnerBookingRouter.createModule(bookingReservation: bookingReservation), HistoryPartnerRouter.createModule()]
    }
    
    func callAPICheckout(bookingID: String, code: String, license_plates: String) {
        ProgressView.shared.showProgressOnWindow()
        Provider.shared.parkingAPIService.checkoutParking(bookingID: bookingID, code: code, license_plates: license_plates, success: { (historyParking) in
            guard let _historyParking = historyParking else { return }
            let intendCheckin = _historyParking.intend_checkin_time?.toString(dateFormat: .ecoTime)
            let intendCheckout = _historyParking.intend_checkout_time?.toString(dateFormat: .ecoTime)
            ProgressView.shared.hide()
            PopUpHelper.shared.showCheckOut(name: _historyParking.fullname&, licensePlate: _historyParking.license_plates&, time: intendCheckin&, timeOut: intendCheckout&, width: 350, height: 280, completionYes: {
                Provider.shared.parkingAPIService.changeStatusCheckout(bookingID: bookingID,
                                                                                                                                                                                                                          bonus: "\(historyParking?.bonus ?? 0)",
                    plus_wallet_boss: "\(historyParking?.plus_wallet_boss ?? 0)",
                    parking_price: "\(historyParking?.parking_price ?? 0)",
                    payment_wallet: "\(historyParking?.payment_wallet ?? 0)",
                    success: { (parkingDetail) in
                        ProgressView.shared.hide()
                        self.push(controller: HistoryPartnerDetailCheckoutRouter.createModule(bookingID: parkingDetail?.id ?? "", parkingID: parkingDetail?.parking_id ?? ""))
                }) { (_) in
                    ProgressView.shared.hide()
                    }
            }) {
                self.pop()
            }
        }) { (error) in
            
            ProgressView.shared.hide()
            PopUpHelper.shared.showMessage(message: error?.message?.showLanguage ?? "", width: 350, completion: {})
        }
    }
    
    func callAPIHistoryPartner() {
//        var parkingID = UserDefaultHelper.shared.loginUserInfo?.infoParking?.id
//        if parkingID == "" || parkingID == nil {
            let parkingID = UserDefaultHelper.shared.loginUserInfo?.parkingID
//        }
        Provider.shared.parkingAPIService.getHistoryMyParking(parkingID: parkingID&, status: "checked_in", keyword: "", offset: 0, limit: limitLoad, success: { (historyParking) in
            self.parkedNumber = historyParking?.parked_number ?? 0
            self.numberPlace = historyParking?.number_place ?? "0"
            self.bookingReservation = historyParking?.booking_reservation ?? 0
            self.reloadPagerTabStripView()
        }) { (error) in
            
        }
    }
}
