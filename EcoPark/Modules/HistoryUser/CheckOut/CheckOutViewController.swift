//
//  CheckOutViewController.swift
//  EcoPark
//
//  Created Henry on 11/2/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class CheckOutViewController: BaseViewController, CheckOutViewProtocol {

	var presenter: CheckOutPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        addBackToNavigation()
        setTitleNavigation(title: "Check out")
        
    }

}
