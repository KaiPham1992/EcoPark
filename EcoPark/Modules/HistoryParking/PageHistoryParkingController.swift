//
//  PageHistoryParkingController.swift
//  EcoPark
//
//  Created by Steve on 11/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class PageHistoryParkingController : PageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleNavigation(title: "Lịch sử đỗ xe")
        addButtonImageToNavigation(image: #imageLiteral(resourceName: "ic_menu"), style: StyleNavigation.left, action: #selector(openMenu))
        addButtonImageToNavigation(image: #imageLiteral(resourceName: "ic_qrcheckin"), style: StyleNavigation.right, action: #selector(checkQrCode))
    }
    
    @objc func openMenu(){
        
    }
    
    @objc func checkQrCode() {
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [HistoryParkingRouter.createModule(type: TypeHistoryParking.doing), HistoryParkingRouter.createModule(type: TypeHistoryParking.history)]
    }
}
