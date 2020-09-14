//
//  HistoryPartnerQRScannerRouter.swift
//  EcoPark
//
//  Created Henry on 11/4/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryPartnerQRScannerRouter: HistoryPartnerQRScannerWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule(isCheckIn: Bool) -> HistoryPartnerQRScannerViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = HistoryPartnerQRScannerViewController(nibName: nil, bundle: nil)
        let interactor = HistoryPartnerQRScannerInteractor()
        let router = HistoryPartnerQRScannerRouter()
        let presenter = HistoryPartnerQRScannerPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        view.isCheckIn = isCheckIn

        return view
    }
}
