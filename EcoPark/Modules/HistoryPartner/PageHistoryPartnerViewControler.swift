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
        self.push(controller: HistoryPartnerQRScannerRouter.createModule())
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [HistoryPartnerHoldingRouter.createModule(), HistoryPartnerBookingRouter.createModule(), HistoryPartnerRouter.createModule()]
    }
}
