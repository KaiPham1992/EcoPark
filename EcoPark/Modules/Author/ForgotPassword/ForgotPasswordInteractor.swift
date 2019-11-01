//
//  ForgotPasswordInteractor.swift
//  EnglishApp
//
//  Created Kai Pham on 5/11/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ForgotPasswordInteractor: ForgotPasswordInteractorInputProtocol {

    weak var presenter: ForgotPasswordInteractorOutputProtocol?
    
    func forgotPassword(email: String) {
        ProgressView.shared.show()
        Provider.shared.userAPIService.forgotPassword(email: email, success: { (data) in
            ProgressView.shared.hide()
            self.presenter?.didForgotPassword(data: data)
        }) { (error) in
            ProgressView.shared.hide()
            self.presenter?.didForgotPassword(error: error)
        }
    }
}