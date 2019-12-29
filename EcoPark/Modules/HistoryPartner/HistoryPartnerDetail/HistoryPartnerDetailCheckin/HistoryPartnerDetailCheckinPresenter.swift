//
//  HistoryPartnerDetailCheckinPresenter.swift
//  EcoPark
//
//  Created Tu DV on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryPartnerDetailCheckinPresenter: HistoryPartnerDetailCheckinPresenterProtocol, HistoryPartnerDetailCheckinInteractorOutputProtocol {

    weak private var view: HistoryPartnerDetailCheckinViewProtocol?
    var interactor: HistoryPartnerDetailCheckinInteractorInputProtocol?
    private let router: HistoryPartnerDetailCheckinWireframeProtocol

    init(interface: HistoryPartnerDetailCheckinViewProtocol, interactor: HistoryPartnerDetailCheckinInteractorInputProtocol?, router: HistoryPartnerDetailCheckinWireframeProtocol) {
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
    
    func changeStatusCheckout(bookingID: String, bonus: String, plus_wallet_boss: String, parking_price: String, payment_wallet: String) {
        ProgressView.shared.showProgressOnWindow()
//        Provider.shared.bookingAPIService.checkOut(bookingId: bookingID, success: { (historyCheckout) in
//            ProgressView.shared.hide()
//            self.view?.didChangeStatusCheckout(historyCheckout: historyCheckout)
//        }) { (_) in
//            ProgressView.shared.hide()
//        }
        Provider.shared.parkingAPIService.changeStatusCheckout(bookingID: bookingID, bonus: bonus, plus_wallet_boss: plus_wallet_boss, parking_price: parking_price, payment_wallet: payment_wallet, success: { (historyCheckout) in
            ProgressView.shared.hide()
            guard let _historyCheckout = historyCheckout else { return }
            self.view?.didChangeStatusCheckout(historyCheckout: _historyCheckout)
        }) { (_) in
            ProgressView.shared.hide()
        }
    }
}
