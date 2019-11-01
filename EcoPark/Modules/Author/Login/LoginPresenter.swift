//
//  LoginPresenter.swift
//  EnglishApp
//
//  Created Kai Pham on 5/9/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class LoginPresenter: LoginPresenterProtocol {

    weak private var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    private let router: LoginWireframeProtocol

    init(interface: LoginViewProtocol, interactor: LoginInteractorInputProtocol?, router: LoginWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func login(email: String, password: String) {
        interactor?.login(email: email, password: password)
    }
    
    func loginSocial(param: LoginSocialParam) {
        interactor?.loginSocial(param: param)
    }

}


extension LoginPresenter: LoginInteractorOutputProtocol {
    func didLogin(user: UserEntity?) {
        view?.didLogin(user: user)
    }
    
    func didLogin(error: APIError?) {
        view?.didError(error: error)
    }
}