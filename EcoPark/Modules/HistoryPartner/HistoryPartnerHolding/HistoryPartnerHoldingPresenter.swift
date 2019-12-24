//
//  HistoryPartnerHoldingPresenter.swift
//  EcoPark
//
//  Created Tu DV on 11/2/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryPartnerHoldingPresenter: HistoryPartnerHoldingPresenterProtocol, HistoryPartnerHoldingInteractorOutputProtocol {

    weak private var view: HistoryPartnerHoldingViewProtocol?
    var interactor: HistoryPartnerHoldingInteractorInputProtocol?
    private let router: HistoryPartnerHoldingWireframeProtocol

    init(interface: HistoryPartnerHoldingViewProtocol, interactor: HistoryPartnerHoldingInteractorInputProtocol?, router: HistoryPartnerHoldingWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getHistoryReservation(parkingID: String, status: String, keyword: String) {
        ProgressView.shared.showProgressOnWindow()
        Provider.shared.parkingAPIService.getHistoryMyParking(parkingID: parkingID, status: status, keyword: keyword, success: { (historyParking) in
            ProgressView.shared.hide()
            self.view?.didGetHistoryReservation(historyParking: historyParking)
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
    
    func checkoutParking(bookingID: String, code: String, licensePlates: String) {
        ProgressView.shared.showProgressOnWindow()
        Provider.shared.parkingAPIService.checkoutParking(bookingID: bookingID, code: code, license_plates: licensePlates, success: { (historyParkingDetail) in
            ProgressView.shared.hide()
            self.view?.didCheckout(historyParkingDetail: historyParkingDetail)
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
    
    func changeStatusCheckout(booking: String) {
        ProgressView.shared.showProgressOnWindow()
        Provider.shared.bookingAPIService.checkOut(bookingId: booking, success: { (_) in
            ProgressView.shared.hide()
            self.view?.didChangeStatusCheckout()
        }) { (_) in
            ProgressView.shared.hide()
        }
    }
}
