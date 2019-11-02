//
//  HistoryPartnerHoldingRouter.swift
//  EcoPark
//
//  Created Tu DV on 11/2/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryPartnerHoldingRouter: HistoryPartnerHoldingWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = HistoryPartnerHoldingViewController(nibName: nil, bundle: nil)
        let interactor = HistoryPartnerHoldingInteractor()
        let router = HistoryPartnerHoldingRouter()
        let presenter = HistoryPartnerHoldingPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}