//
//  ParkingUserDetailProtocols.swift
//  EnglishApp
//
//  Created Ngoc Duong on 10/30/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol ParkingUserDetailWireframeProtocol: class {

}
//MARK: Presenter -
protocol ParkingUserDetailPresenterProtocol: class {

    var interactor: ParkingUserDetailInteractorInputProtocol? { get set }
    func getParkingInfo(id: String)
}

//MARK: Interactor -
protocol ParkingUserDetailInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func didGetError(error: APIError)
    func didGetInfo(info: ParkingInfoEntity)
}

protocol ParkingUserDetailInteractorInputProtocol: class {

    var presenter: ParkingUserDetailInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func getParkingInfo(id: String)
}

//MARK: View -
protocol ParkingUserDetailViewProtocol: class {

    var presenter: ParkingUserDetailPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func didGetError(error: APIError)
    func didGetInfo(info: ParkingInfoEntity)
}
