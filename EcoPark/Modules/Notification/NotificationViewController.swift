//
//  Notification.swift
//  EcoPark
//
//  Created by Henry on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class NotificationViewController: PageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleNavigation(title: LocalizableKey.MenuNotification.showLanguage)
        self.view.backgroundColor = AppColor.black
        addButtonImageToNavigation(image: #imageLiteral(resourceName: "ic_menu"), style: StyleNavigation.left, action: #selector(openMenu))
    }
    
    @objc func openMenu() {
        if let containerController = navigationController?.parent as? ContainerViewController {
                   containerController.toggleLeftPanel()
               }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [MyNotificationRouter.createModule(), SystemNotificationRouter.createModule()]
    }
}
