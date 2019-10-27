//
//  MenuContainner.swift
//  Ipos
//
//  Created by Coby on 4/23/19.
//  Copyright © 2019 edward. All rights reserved.
//

import UIKit

class NecContainerViewController : ContainerViewController {
    
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
        menuVC.delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
