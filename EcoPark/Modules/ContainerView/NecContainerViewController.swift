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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeVC = HomeRouter.createModule()
        
        //Initial menu
        self.openViewController(presentingController: homeVC)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReciveNotification), name: NSNotification.Name.init("didReciveNotification"), object: nil)
    }
    
    @objc func didReciveNotification(notification: Notification){
        if let action_key = notification.userInfo?["click_action"] as? String {
            switch action_key {
            case NotificationKey.NOTIF_ALL.rawValue, NotificationKey.NOTIF_ALL_CLIENT.rawValue, NotificationKey.NOTIF_ALL_BOSS.rawValue:
                if let oid = notification.userInfo?["gcm.notification.nid"] as? String, let id = Int(oid) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let vc = NotificationViewController()
                        self.openViewController(presentingController: vc)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            let vcPush = NotificationDetailRouter.createModule(notificationID: id, content: "")
                            self.pushViewController(presentingController: vcPush)
                        }
                    }
                }
            case NotificationKey.NOTIF_CHECK_TIME_OUT.rawValue, NotificationKey.NOTIF_BOOKING_EXPIRED_FOR_CUS.rawValue, NotificationKey.NOTIF_CHECK_INTEND_CHEKCIN_TIME.rawValue, NotificationKey.NOTIF_RATING_FOR_CUSTOMER.rawValue, NotificationKey.NOTIF_STATUS_CANCEL.rawValue:
                if let oid = notification.userInfo?["gcm.notification.nid"] as? String {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let vc = PageHistoryParkingController()
                        self.openViewController(presentingController: vc)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            let bookingParking = HistoryBookingParkingResponse()
                            bookingParking.id = oid
                            let vcPush = DetailParkingRouter.createModule(bookingParking: bookingParking)
                            self.pushViewController(presentingController: vcPush)
                        }
                    }
                }
                
            // fix for owner 
            case NotificationKey.NOTIF_BOOKING_EXPIRED_FOR_BOSS.rawValue, NotificationKey.NOTIF_RATING_FOR_BOSS_PARKING.rawValue, NotificationKey.NOTIF_BOOKING_FOR_BOSS.rawValue, NotificationKey.NOTIF_EXTRA.rawValue, NotificationKey.NOTIF_STATUS_CANCEL.rawValue:
                if let oid = notification.userInfo?["gcm.notification.nid"] as? String {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let vc = PageHistoryPartnerViewControler()
                        self.openViewController(presentingController: vc)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            let bookingParking = HistoryBookingParkingResponse()
                            bookingParking.id = oid
                            let vcPush = DetailParkingRouter.createModule(bookingParking: bookingParking)
                            self.pushViewController(presentingController: vcPush)
                        }
                    }
                }
                
            case NotificationKey.THE_WALLET_RUNS_OUT_OF_MONEY.rawValue, NotificationKey.NOTIF_PLUS.rawValue, NotificationKey.NOTIF_PLUS_MONEY_FOR_BOSS.rawValue:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                     let wallet = WalletRouter.createModule()
                    self.openViewController(presentingController: wallet)
                }
                
            default:
                break
            }
        }
        
        if let nid = notification.userInfo?["gcm.notification.nid"] as? String, let id = Int(nid){
            Provider.shared.notificationAPIService.readNotification(notificationId: id, success: { _ in
                
            }) { _ in
                
            }
        }
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
        case AppImage.imgCall:

            if let url = URL(string: "tel://1900587") {
                UIApplication.shared.open(url)
            }
           self.openViewController(presentingController: homeVC)
        default:
            self.openViewController(presentingController: homeVC)
        }
        
    }
    
}

