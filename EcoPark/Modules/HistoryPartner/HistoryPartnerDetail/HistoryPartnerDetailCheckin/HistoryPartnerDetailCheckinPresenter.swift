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
            self.view?.didGetData(historyPakingDetail: historyParkingDetail)
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
}
