//
//  ChangePasswordProtocols.swift
//  EnglishApp
//
//  Created Kai Pham on 5/12/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol ChangePasswordWireframeProtocol: class {

}
//MARK: Presenter -
protocol ChangePasswordPresenterProtocol: class {

    var interactor: ChangePasswordInteractorInputProtocol? { get set }
    func changePassword(password: String, newPassword: String)
}

//MARK: Interactor -
protocol ChangePasswordInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func didChangePassword(data: BaseResponseString?)
    func didChangePassword(error: APIError?)
}

protocol ChangePasswordInteractorInputProtocol: class {

    var presenter: ChangePasswordInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func changePassword(password: String, newPassword: String)
}

//MARK: View -
protocol ChangePasswordViewProtocol: class {

    var presenter: ChangePasswordPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func didChangePassword(data: BaseResponseString?)
    func didChangePassword(error: APIError?)
}
