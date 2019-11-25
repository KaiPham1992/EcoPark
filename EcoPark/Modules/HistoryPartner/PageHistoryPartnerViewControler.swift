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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleNavigation(title: "Lịch sử giao dịch bãi xe")
        addButtonImageToNavigation(image: #imageLiteral(resourceName: "ic_menu"), style: StyleNavigation.left, action: #selector(openMenu))
        addButtonImageToNavigation(image: #imageLiteral(resourceName: "ic_qrcheckout"), style: StyleNavigation.right, action: #selector(checkQrCode))
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
            print(qrcode)
            let bookingID = qrcode[2]
            let code = qrcode[4]
            let licensePlates = qrcode[3]
            self.callAPICheckout(bookingID: bookingID, code: code, license_plates: licensePlates)
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
            
        }
    }
    
}
