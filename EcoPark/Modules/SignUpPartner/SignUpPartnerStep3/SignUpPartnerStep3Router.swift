//
//  SignUpPartnerStep3Router.swift
//  EnglishApp
//
//  Created Tu DV on 10/31/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SignUpPartnerStep3Router: SignUpPartnerStep3WireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule(param: BossRegisterParam) -> SignUpPartnerStep3ViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = SignUpPartnerStep3ViewController(nibName: nil, bundle: nil)
        let interactor = SignUpPartnerStep3Interactor()
        let router = SignUpPartnerStep3Router()
        let presenter = SignUpPartnerStep3Presenter(interface: view, interactor: interactor, router: router)
        
        view.param = param
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
