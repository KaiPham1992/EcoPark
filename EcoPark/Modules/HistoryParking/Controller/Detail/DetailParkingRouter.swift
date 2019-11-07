//
//  DetailParkingRouter.swift
//  EcoPark
//
//  Created Steve on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

enum TypeDetailParking {
    case checkin
    case checkout
    case complete
}

class DetailParkingRouter: DetailParkingWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = DetailParkingViewController(nibName: nil, bundle: nil)
        let interactor = DetailParkingInteractor()
        let router = DetailParkingRouter()
        let presenter = DetailParkingPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    static func createModule(type: TypeDetailParking) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = DetailParkingViewController(nibName: nil, bundle: nil)
        let interactor = DetailParkingInteractor()
        let router = DetailParkingRouter()
        let presenter = DetailParkingPresenter(interface: view, interactor: interactor, router: router)
        view.type = type
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}