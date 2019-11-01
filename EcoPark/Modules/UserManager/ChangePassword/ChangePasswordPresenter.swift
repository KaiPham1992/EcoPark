//
//  ChangePasswordPresenter.swift
//  EnglishApp
//
//  Created Kai Pham on 5/12/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

import UIKit

class ChangePasswordPresenter: ChangePasswordPresenterProtocol {
    
    weak private var view: ChangePasswordViewProtocol?
    var interactor: ChangePasswordInteractorInputProtocol?
    private let router: ChangePasswordWireframeProtocol
    
    init(interface: ChangePasswordViewProtocol, interactor: ChangePasswordInteractorInputProtocol?, router: ChangePasswordWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func changePassword(password: String, newPassword: String) {
        interactor?.changePassword(password: password, newPassword: newPassword)
    }
}

extension ChangePasswordPresenter: ChangePasswordInteractorOutputProtocol {
    func didChangePassword(data: BaseResponseString?) {
        view?.didChangePassword(data: data)
    }
    
    func didChangePassword(error: APIError?) {
        view?.didChangePassword(error: error)
    }
}