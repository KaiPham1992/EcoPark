//
//  NotificationDetailProtocols.swift
//  EcoPark
//
//  Created Henry on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol NotificationDetailWireframeProtocol: class {

}
//MARK: Presenter -
protocol NotificationDetailPresenterProtocol: class {

    var interactor: NotificationDetailInteractorInputProtocol? { get set }
}

//MARK: Interactor -
protocol NotificationDetailInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol NotificationDetailInteractorInputProtocol: class {

    var presenter: NotificationDetailInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol NotificationDetailViewProtocol: class {

    var presenter: NotificationDetailPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
