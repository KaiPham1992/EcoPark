//
//  NotificationListPresenter.swift
//  EnglishApp
//
//  Created Kai Pham on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class NotificationListPresenter: NotificationListPresenterProtocol, NotificationListInteractorOutputProtocol {

    weak private var view: NotificationListViewProtocol?
    var interactor: NotificationListInteractorInputProtocol?
    private let router: NotificationListWireframeProtocol
    

    init(interface: NotificationListViewProtocol, interactor: NotificationListInteractorInputProtocol?, router: NotificationListWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getNotification(offset: Int) {
        Provider.shared.notificationAPIService.getNotification(offset: offset, success: { object in
            guard let list = object?.notifications else { return }
            self.view?.didLoadNotification(listNotification: list)
        }) { error in
        }
    }
    
    func readNotification(id: Int) {
        Provider.shared.notificationAPIService.readNotification(notificationId: id, success: { _ in
            if UIApplication.shared.applicationIconBadgeNumber > 0 {
                UIApplication.shared.applicationIconBadgeNumber -= 1
            }
        }) { _ in
            
        }
    }

    
}