//
//  MenuContainner.swift
//  Ipos
//
//  Created by Coby on 4/23/19.
//  Copyright © 2019 edward. All rights reserved.
//

import UIKit

class NecContainerViewController: ContainerViewController {
    
    var homeVC:  HomeViewController!
    let menuVC = MenuRouter.createModule()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeVC = HomeRouter.createModule()
        
        //Initial menu
        self.openViewController(presentingController: homeVC)
    }
    
     init() {
        super.init(drawerDirection: .left, drawerWidth: 300, menuViewController: menuVC)
        menuVC.delegateController = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NecContainerViewController: MenuViewControllerDelegate {
    func selected(item: MenuItem) {
        guard let icon = item.imgIcon else { return }
        switch icon {
        case AppImage.imgPrivacy:
            let webView = WebViewController.initFromNib()
            self.openViewController(presentingController: webView)
        case AppImage.imgSecurity:
            let webView = WebViewController.initFromNib()
            self.openViewController(presentingController: webView)
        default:
            self.openViewController(presentingController: homeVC)
        }
        
    }
   
}

