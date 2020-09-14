//
//  SignUpInteractor.swift
//  EnglishApp
//
//  Created Kai Pham on 5/11/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SignUpInteractor: SignUpInteractorInputProtocol {

    weak var presenter: SignUpInteractorOutputProtocol?
    
    
    func getCaptcha() {
        ProgressView.shared.show()
        Provider.shared.userAPIService.getCaptcha(success: {(result) in
            ProgressView.shared.hide()
            guard let result = result, let imageStr = result.data as? String, let image = imageStr.toUIImage() else { return }
            self.presenter?.successCaptcha(image: image)
        }) { (error) in
            ProgressView.shared.hide()
            print("error")
        }
    }
    
    func signUp(param: SignUpParam) {
        ProgressView.shared.show()
        Provider.shared.userAPIService.signUp(param: param, success: { (user) in
            ProgressView.shared.hide()
            guard let user = user else { return}
            UserDefaultHelper.shared.saveUser(user: user)
            UserDefaultHelper.shared.userToken = user.jwt&
            self.presenter?.signUpSuccess(user: user)
            UserDefaultHelper.shared.parkingID = user.parkingID ?? ""
        }) { (error) in
            ProgressView.shared.hide()
            guard let error = error else { return }
            self.presenter?.signUpError(error: error)
        }
    }
}
