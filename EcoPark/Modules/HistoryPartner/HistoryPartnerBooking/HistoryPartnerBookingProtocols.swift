//
//  HistoryPartnerBookingProtocols.swift
//  EcoPark
//
//  Created Tu DV on 11/2/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol HistoryPartnerBookingWireframeProtocol: class {

}
//MARK: Presenter -
protocol HistoryPartnerBookingPresenterProtocol: class {

    var interactor: HistoryPartnerBookingInteractorInputProtocol? { get set }
    func getHistoryParkingBooking(parkingID: String, status: String, keyword: String)
}

//MARK: Interactor -
protocol HistoryPartnerBookingInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol HistoryPartnerBookingInteractorInputProtocol: class {

    var presenter: HistoryPartnerBookingInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol HistoryPartnerBookingViewProtocol: class {

    var presenter: HistoryPartnerBookingPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func didGetHistoryParkingBooking(historyParking: HistoryMyParkingEntity?) 
}
