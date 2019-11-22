//
//  HistoryPartnerPresenter.swift
//  EcoPark
//
//  Created Tu DV on 11/4/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryPartnerPresenter: HistoryPartnerPresenterProtocol, HistoryPartnerInteractorOutputProtocol {

    weak private var view: HistoryPartnerViewProtocol?
    var interactor: HistoryPartnerInteractorInputProtocol?
    private let router: HistoryPartnerWireframeProtocol

    init(interface: HistoryPartnerViewProtocol, interactor: HistoryPartnerInteractorInputProtocol?, router: HistoryPartnerWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getHistoryParking(parkingID: String, status: String, keyword: String) {
        Provider.shared.parkingAPIService.getHistoryMyParking(parkingID: parkingID, status: status, keyword: keyword, success: { (historyParking) in
            self.view?.didGetHistoryParking(historyParking: historyParking)
        }) { (error) in
            
        }
    }
}
