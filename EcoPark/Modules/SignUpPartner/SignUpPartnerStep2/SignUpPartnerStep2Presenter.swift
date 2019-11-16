//
//  SignUpPartnerStep2Presenter.swift
//  EnglishApp
//
//  Created Tu DV on 10/30/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SignUpPartnerStep2Presenter: SignUpPartnerStep2PresenterProtocol, SignUpPartnerStep2InteractorOutputProtocol {
    
    func uploadImageFront(image: UIImage) {
        Provider.shared.commonAPIService.uploadImage(image: image, success: { (photo) in
            self.view?.didUploadImageFront(photo: photo?.imgSrc)
        }) { (error) in
            
        }
    }
    
    func uploadImageBackside(image: UIImage) {
        Provider.shared.commonAPIService.uploadImage(image: image, success: { (photo) in
            self.view?.didUploadImageBackside(photo: photo?.imgSrc)
        }) { (error) in
            
        }
    }
    
    
    func getListParkingType() {
        Provider.shared.parkingAPIService.getParkingType(success: { (listParkingType) in
            self.view?.didGetListParkingType(listParkingType: listParkingType)
        }) { (error) in
            
        }
    }
    

    weak private var view: SignUpPartnerStep2ViewProtocol?
    var interactor: SignUpPartnerStep2InteractorInputProtocol?
    private let router: SignUpPartnerStep2WireframeProtocol

    init(interface: SignUpPartnerStep2ViewProtocol, interactor: SignUpPartnerStep2InteractorInputProtocol?, router: SignUpPartnerStep2WireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
