//
//  HomePresenter.swift
//  EnglishApp
//
//  Created Ngoc Duong on 10/22/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HomePresenter: HomePresenterProtocol, HomeInteractorOutputProtocol {

    weak private var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    private let router: HomeWireframeProtocol

    init(interface: HomeViewProtocol, interactor: HomeInteractorInputProtocol?, router: HomeWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getProfileUser() {
        Provider.shared.userAPIService.getProfileUser(success: { (user) in
            guard let _user = user else { return }
            self.view?.didGetProfileUser(user: _user)
        }) { (_) in
            
        }
    }
}
