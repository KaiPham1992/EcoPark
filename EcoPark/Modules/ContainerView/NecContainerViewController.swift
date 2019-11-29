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
    func loginTapped() {
        let vc = LoginRouter.createModule()
        vc.callBackLoginSuccessed = {
            self.menuVC.viewWillAppear(true)
        }
        self.present(controller: UINavigationController(rootViewController: vc))
    }
    
    func signUpPartnerTapped() {
        let signUpPartnerVC = SignUpPartnerStep1Router.createModule()
        self.openViewController(presentingController: signUpPartnerVC)
    }
    
    func selected(item: MenuItem) {
        guard let icon = item.imgIcon else { return }
        switch icon {
        case AppImage.imgHistoryParking:
            let vcHistoryParking = PageHistoryPartnerViewControler()
            self.openViewController(presentingController: vcHistoryParking)
        case AppImage.imgMyParking:
            let vcParkingInfo = ParkingInfoRouter.createModule()
            self.openViewController(presentingController: vcParkingInfo)
        case AppImage.imgPrivacy:
            let webView = WebViewController.createModule(isTermCondition: true)
            self.openViewController(presentingController: webView)
        case AppImage.imgSecurity:
            let webView = WebViewController.createModule(isTermCondition: false)
            self.openViewController(presentingController: webView)
        case AppImage.imgProfile:
            let profile = ProfileRouter.createModule()
            self.openViewController(presentingController: profile)
        case AppImage.imgWallet:
            let wallet = WalletRouter.createModule()
            self.openViewController(presentingController: wallet)
        case AppImage.imgNotification:
            let vc = NotificationViewController()
            self.openViewController(presentingController: vc)
        case AppImage.imgHistory:
            let vc = PageHistoryParkingController()
            self.openViewController(presentingController: vc)
        default:
            self.openViewController(presentingController: homeVC)
        }
        
    }
    
}

