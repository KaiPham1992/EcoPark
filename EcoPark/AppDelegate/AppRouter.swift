//
//  AppRouter.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/12/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

class AppRouter {
    static let shared = AppRouter()
    
    var rootNavigation: UINavigationController?
    
//    func updateRootView() {
//        if !UserDefaultHelper.shared.userToken&.isEmpty  {
//            openHome()
//        } else {
//            openLogin()
//        }
//    }

    
    func pushTo(viewController: UIViewController) {
        viewController.hidesBottomBarWhenPushed = true
        rootNavigation?.pushViewController(viewController, animated: true)
    }
    
    func openLogin() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        //---
        AppRouter.shared.rootNavigation = nil
        let vcLogin = LoginRouter.createModule()
        
        let nc = UINavigationController(rootViewController: vcLogin)
        windowApp.rootViewController = nc
    }
    
    func openTest() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        //---
//        let vcLogin = HomeRouter.createModule()

//        let nc = UINavigationController(rootViewController: vcLogin)
        windowApp.rootViewController = NecContainerViewController()
    }
    
    func openHome() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        //---
        let homeVC = LoginRouter.createModule()


//        let homeVC = HomeRouter.createModule()

        windowApp.rootViewController = UINavigationController(rootViewController: homeVC)
    }
}
