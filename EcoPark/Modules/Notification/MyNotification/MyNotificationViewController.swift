//
//  MyNotificationViewController.swift
//  EcoPark
//
//  Created Henry on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class MyNotificationViewController: ListManagerVC, MyNotificationViewProtocol {
   
	var presenter: MyNotificationPresenterProtocol?
    
    var notification: [NotificationEntity] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.initLoadData(data: Array(repeating: 1, count: self.notification.count))
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getNotification(screen: "notification", offset: 0, limit: limitLoad)
    }
    
    override func registerTableView() {
        super.registerTableView()
        self.tableView.registerXibFile(NotificationCell.self)
        self.view.backgroundColor = .clear

    }
    
    override func cellForRowListManager(item: Any, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeue(NotificationCell.self, for: indexPath)
        let status = notification[indexPath.item].isRead
        var statusType: NotificationStatus = .UnRead
        if status ?? false {
            statusType = NotificationStatus.IsRead
        } else {
            statusType = NotificationStatus.UnRead
        }
        let dateTime = notification[indexPath.item].createTime?.toString(dateFormat: .hhmmddmmyyy)
        let content = notification[indexPath.item].content
        cell.displayData(type: .MyNotification, status: statusType , datetime: dateTime&, content: content&)
        return cell
    }
    
    override func didSelectTableView(item: Any, indexPath: IndexPath) {
        guard let id = notification[indexPath.item].id,
            let notiID = Int(id),
        let content = notification[indexPath.item].content else { return }
        self.push(controller: NotificationDetailRouter.createModule(notificationID: notiID, content: content), animated: true)
    }
    
    func didGetNotification(notification: ParentNotificationEntity?) {
        let noti = notification?.notifications
        guard let notiSystem = (noti?.filter({ (notification) -> Bool in
            notification.screen == "NOTIFICATION"
        })) else { return }
        self.notification = notiSystem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.initLoadData(data: Array(repeating: 1, count: self.notification.count ))
        }
    }
}

extension MyNotificationViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: LocalizableKey.Giveme.showLanguage)
    }
}
