//
//  BookingInfoRouter.swift
//  EnglishApp
//
//  Created Ngoc Duong on 10/29/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class BookingInfoRouter: BookingInfoWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = BookingInfoViewController(nibName: nil, bundle: nil)
        let interactor = BookingInfoInteractor()
        let router = BookingInfoRouter()
        let presenter = BookingInfoPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
