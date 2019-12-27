//
//  HistoryPartnerDetailCheckoutRouter.swift
//  EcoPark
//
//  Created Tu DV on 11/20/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryPartnerDetailCheckoutRouter: HistoryPartnerDetailCheckoutWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = HistoryPartnerDetailCheckoutViewController(nibName: nil, bundle: nil)
        let interactor = HistoryPartnerDetailCheckoutInteractor()
        let router = HistoryPartnerDetailCheckoutRouter()
        let presenter = HistoryPartnerDetailCheckoutPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    static func createModule(historyParkingDetail: HistoryBookingParkingResponse?) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = HistoryPartnerDetailCheckoutViewController(nibName: nil, bundle: nil)
        let interactor = HistoryPartnerDetailCheckoutInteractor()
        let router = HistoryPartnerDetailCheckoutRouter()
        let presenter = HistoryPartnerDetailCheckoutPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        view.historyParkingDetail = historyParkingDetail
        return view
    }
    
    static func createModule(bookingID: String, parkingID: String) -> HistoryPartnerDetailCheckoutViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = HistoryPartnerDetailCheckoutViewController(nibName: nil, bundle: nil)
        let interactor = HistoryPartnerDetailCheckoutInteractor()
        let router = HistoryPartnerDetailCheckoutRouter()
        let presenter = HistoryPartnerDetailCheckoutPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        view.bookingID = bookingID
        view.parkingID = parkingID
        
        return view
    }
}
