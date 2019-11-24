//
//  DetailParkingProtocols.swift
//  EcoPark
//
//  Created Steve on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol DetailParkingWireframeProtocol: class {

}
//MARK: Presenter -
protocol DetailParkingPresenterProtocol: class {

    var interactor: DetailParkingInteractorInputProtocol? { get set }
    func getBookingDetail(id: String)
    func cancelReservation(id: String)
    func extendReservation(id: String)
    func scanQRCheckIn(parkingId: String, bossParkingId: String)
    func scanQRCheckOut(bookingId: String, code: String, licensePlates: String)
    func ratingBooking(bookingId: String, rating: String)
}

//MARK: Interactor -
protocol DetailParkingInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func didGetBookingDetail(info: BookingDetailEntity)
    func didGetError(error: APIError)
    func didCancelReservation()
    func didExtendReservation(info: BookingDetailEntity)
}

protocol DetailParkingInteractorInputProtocol: class {

    var presenter: DetailParkingInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func getBookingDetail(id: String)
    func cancelReservation(id: String)
    func extendReservation(id: String)
}

//MARK: View -
protocol DetailParkingViewProtocol: class {

    var presenter: DetailParkingPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func didGetError(error: APIError)
    func didGetBookingDetail(info: BookingDetailEntity)
    func didGetRating(rating: RatingEntity)
    func didCancelReservation()
    func didExtendReservation(info: BookingDetailEntity)
   
}
