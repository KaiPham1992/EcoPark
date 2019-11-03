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
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [HistoryParkingRouter.createModule(type: TypeHistoryParking.doing), HistoryParkingRouter.createModule(type: TypeHistoryParking.history)]
    }
}
