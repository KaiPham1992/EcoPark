//
//  ImageParkingRouter.swift
//  EcoPark
//
//  Created Tu DV on 11/16/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ImageParkingRouter: ImageParkingWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule(listImage: [String]) -> ImageParkingViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ImageParkingViewController(nibName: nil, bundle: nil)
        let interactor = ImageParkingInteractor()
        let router = ImageParkingRouter()
        let presenter = ImageParkingPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        view.listImage = listImage
        return view
    }
}
