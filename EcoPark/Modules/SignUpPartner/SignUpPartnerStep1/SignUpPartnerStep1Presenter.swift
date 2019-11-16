//
//  SignUpPartnerStep1Presenter.swift
//  EnglishApp
//
//  Created Tu DV on 10/29/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SignUpPartnerStep1Presenter: SignUpPartnerStep1PresenterProtocol, SignUpPartnerStep1InteractorOutputProtocol {

    weak private var view: SignUpPartnerStep1ViewProtocol?
    var interactor: SignUpPartnerStep1InteractorInputProtocol?
    private let router: SignUpPartnerStep1WireframeProtocol

    init(interface: SignUpPartnerStep1ViewProtocol, interactor: SignUpPartnerStep1InteractorInputProtocol?, router: SignUpPartnerStep1WireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func uploadImageFront(image: UIImage) {
        Provider.shared.commonAPIService.uploadImage(image: image, success: { (photo) in
            self.view?.didUploadImageFront(photo: photo)
        }) { (error) in
            
        }
    }
    
    func uploadImageBackside(image: UIImage) {
        Provider.shared.commonAPIService.uploadImage(image: image, success: { (photo) in
            self.view?.didUploadImageBackside(photo: photo)
        }) { (error) in
            
        }
    }
    
}
