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
    
    func openHomeView() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        //---
//        let vcLogin = HomeRouter.createModule()

//        let nc = UINavigationController(rootViewController: vcLogin)
        windowApp.rootViewController = NecContainerViewController()
    }
    
    func openHome() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        //---
//        let homeVC = LoginRouter.createModule()



        let homeVC = SignUpRouter.createModule()

        windowApp.rootViewController = UINavigationController(rootViewController: homeVC)
    }
    
    func test() {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        
            let vc = WalletRouter.createModule()
            windowApp.rootViewController = UINavigationController(rootViewController: vc)
        }
}
