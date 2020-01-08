//
//  MyNotificationPresenter.swift
//  EcoPark
//
//  Created Henry on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MyNotificationPresenter: MyNotificationPresenterProtocol, MyNotificationInteractorOutputProtocol {

    weak private var view: MyNotificationViewProtocol?
    var interactor: MyNotificationInteractorInputProtocol?
    private let router: MyNotificationWireframeProtocol

    init(interface: MyNotificationViewProtocol, interactor: MyNotificationInteractorInputProtocol?, router: MyNotificationWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func getNotification(screen: String, offset: Int, limit: Int) {
        ProgressView.shared.showProgressOnWindow()
        Provider.shared.notificationAPIService.getNotification(offset: offset, limit: limit, screen: screen, success: { (notification) in
            ProgressView.shared.hide()
            self.view?.didGetNotification(notification: notification)
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
    
    func getNotificationDetail(notificationID: Int) {
        Provider.shared.notificationAPIService.getNotificationDetail(id: notificationID, success: { (_) in
            
        }) { (_) in
            
        }
    }
}
