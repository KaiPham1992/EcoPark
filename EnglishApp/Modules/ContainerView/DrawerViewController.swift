//
//  DrawerViewController.swift
//  Ipos
//
//  Created by Torres on 5/21/19.
//  Copyright © 2019 edward. All rights reserved.
//

import Foundation
import UIKit

class DrawerViewController: ContainerViewController {
    let menuVC =  MenuRouter.createModule()//MenuViewController.init(nibName: "MenuViewController", bundle: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    init(viewController: UIViewController? = nil) {
        super.init(drawerDirection: .right, drawerWidth: 300, menuViewController: menuVC)
        
        guard let viewController = viewController else {
            return
        }
        menuVC.delegate = self
        self.openViewController(presentingController: viewController)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
