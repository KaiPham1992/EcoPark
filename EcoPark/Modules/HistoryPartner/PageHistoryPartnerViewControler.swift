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
    
    var parkedNumber: Int? = 0
    var numberPlace: Int? = 0
    var bookingReservation: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleNavigation(title: "Lịch sử giao dịch bãi xe")
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
        let vc = AppQRScanerViewController.createModule(isCheckIn: false)
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
        return [HistoryPartnerHoldingRouter.createModule(), HistoryPartnerBookingRouter.createModule(), HistoryPartnerRouter.createModule()]
    }
    
    func callAPICheckout(bookingID: String, code: String, license_plates: String) {
        Provider.shared.parkingAPIService.checkoutParking(bookingID: bookingID, code: code, license_plates: license_plates, success: { (historyParking) in
            self.push(controller: HistoryPartnerDetailCheckoutRouter.createModule(historyParkingDetail: historyParking))
        }) { (_) in
            PopUpHelper.shared.showInvalidQR(height: 350, completion: nil)
        }
    }
    
    func callAPIHistoryPartner() {
        let parkingID = UserDefaultHelper.shared.loginUserInfo?.parkingID
        Provider.shared.parkingAPIService.getHistoryMyParking(parkingID: parkingID&, status: "reversation", keyword: "", success: { (historyParking) in
            self.parkedNumber = historyParking?.parked_number
            self.numberPlace = historyParking?.number_place
            self.bookingReservation = historyParking?.booking_reservation ?? 0
        }) { (error) in
            
        }
    }
}
