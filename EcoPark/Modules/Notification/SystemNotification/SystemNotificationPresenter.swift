//
//  SystemNotificationPresenter.swift
//  EcoPark
//
//  Created Henry on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SystemNotificationPresenter: SystemNotificationPresenterProtocol, SystemNotificationInteractorOutputProtocol {

    weak private var view: SystemNotificationViewProtocol?
    var interactor: SystemNotificationInteractorInputProtocol?
    private let router: SystemNotificationWireframeProtocol

    init(interface: SystemNotificationViewProtocol, interactor: SystemNotificationInteractorInputProtocol?, router: SystemNotificationWireframeProtocol) {
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
}
