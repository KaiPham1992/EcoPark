//
//  ForgotPasswordPresenter.swift
//  EnglishApp
//
//  Created Kai Pham on 5/11/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ForgotPasswordPresenter: ForgotPasswordPresenterProtocol {

    weak private var view: ForgotPasswordViewProtocol?
    var interactor: ForgotPasswordInteractorInputProtocol?
    private let router: ForgotPasswordWireframeProtocol

    init(interface: ForgotPasswordViewProtocol, interactor: ForgotPasswordInteractorInputProtocol?, router: ForgotPasswordWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func forgotPassword(email: String) {
        interactor?.forgotPassword(email: email)
    }

}

extension ForgotPasswordPresenter: ForgotPasswordInteractorOutputProtocol {
    func didForgotPassword(data: BaseResponse?) {
        view?.didForgotPassword(data: data)
    }
    
    func didForgotPassword(error: APIError?) {
        view?.didForgotPassword(error: error)
    }
}
