//
//  HistoryPartnerDetailCheckAgainPresenter.swift
//  EcoPark
//
//  Created Tu DV on 12/29/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryPartnerDetailCheckAgainPresenter: HistoryPartnerDetailCheckAgainPresenterProtocol, HistoryPartnerDetailCheckAgainInteractorOutputProtocol {

    weak private var view: HistoryPartnerDetailCheckAgainViewProtocol?
    var interactor: HistoryPartnerDetailCheckAgainInteractorInputProtocol?
    private let router: HistoryPartnerDetailCheckAgainWireframeProtocol

    init(interface: HistoryPartnerDetailCheckAgainViewProtocol, interactor: HistoryPartnerDetailCheckAgainInteractorInputProtocol?, router: HistoryPartnerDetailCheckAgainWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getHistoryParkingDetailCheckIn(parkingID: String, bookingID: String) {
        ProgressView.shared.showProgressOnWindow()
        Provider.shared.parkingAPIService.getHistoryParkingDetail(parkingID: parkingID, bookingID: bookingID, success: { (historyParkingDetail) in
            ProgressView.shared.hide()
            self.view?.didGetData(historyParkingDetail: historyParkingDetail)
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
            PopUpHelper.shared.showMessage(message: error?.message?.showLanguage ?? "", width: 350, completion: {})
        }
    }
    
    func changeStatusCheckout(bookingID: String) {
        ProgressView.shared.showProgressOnWindow()
        Provider.shared.bookingAPIService.checkOut(bookingId: bookingID, success: { (historyCheckout) in
            ProgressView.shared.hide()
            self.view?.didChangeStatusCheckout(historyCheckout: historyCheckout)
        }) { (_) in
            ProgressView.shared.hide()
        }
    }
}
