//
//  ParkingInfoPresenter.swift
//  EnglishApp
//
//  Created Tu DV on 10/31/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ParkingInfoPresenter: ParkingInfoPresenterProtocol, ParkingInfoInteractorOutputProtocol {

    weak private var view: ParkingInfoViewProtocol?
    var interactor: ParkingInfoInteractorInputProtocol?
    private let router: ParkingInfoWireframeProtocol

    init(interface: ParkingInfoViewProtocol, interactor: ParkingInfoInteractorInputProtocol?, router: ParkingInfoWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getParkingInfo(id: String) {
        ProgressView.shared.showProgressOnWindow()
        Provider.shared.parkingAPIService.getParkingInfo(id: id, success: { (parkingInfo) in
            ProgressView.shared.hide()
            self.view?.didGetParkingInfo(parkingInfo: parkingInfo)
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
    
    func getListParkingType() {
        Provider.shared.parkingAPIService.getParkingType(success: { (parkingType) in
            self.view?.didGetListParkingType(listParkingType: parkingType)
        }) { (error) in
            
        }
    }
    
    func updateInfoParking(param: UpdateInfoParkingParam) {
        ProgressView.shared.showProgressOnWindow()
        Provider.shared.parkingAPIService.updateInfoParking(param: param, success: { (parkingInfo) in
            ProgressView.shared.hide()
            self.view?.didUpdateInfoParking(parkingInfo: parkingInfo)
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
    
    func changeStatusParking(parkingID: String, isActive: String) {
        Provider.shared.parkingAPIService.changeStatusParking(parkingID: parkingID, isActive: isActive, success: { (_) in
            
        }) { (_) in
            
        }
    }
    
    func getNumberHours() {
        Provider.shared.parkingAPIService.getNumberHours(success: { (data) in
            self.view?.didGetNumberHours(numberHours: data?.number_hours ?? "")
        }) { (_) in
            
        }
    }
}
