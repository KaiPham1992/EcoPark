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
    
    func presentLogin(completion: @escaping CompletionClosure) {
        let vc = LoginRouter.createModule()
        vc.callBackLoginSuccessed = completion
        guard let topController = UIApplication.topViewController() else { return }
        topController.present(controller: UINavigationController(rootViewController: vc))
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
        windowApp.rootViewController = NecContainerViewController()
    }
    
    func openLoading() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        
        let vc = LoadingRouter.createModule()
        windowApp.rootViewController = vc
    }
    
    func openParkingInfo() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let windowApp = appDelegate.window else { return }
        
        let vc = ParkingInfoRouter.createModule()
        windowApp.rootViewController = vc
    }
}
