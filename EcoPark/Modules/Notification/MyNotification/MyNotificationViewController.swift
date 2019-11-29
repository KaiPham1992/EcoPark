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
    
    override func setUpViews() {
        super.setUpViews()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.initLoadData(data: Array(repeating: 1, count: 10))
        }
    }

    override func registerTableView() {
        super.registerTableView()
        self.tableView.registerXibFile(NotificationCell.self)
        self.view.backgroundColor = .clear

    }
    
    override func cellForRowListManager(item: Any, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeue(NotificationCell.self, for: indexPath)
        cell.displayData(type: .MyNotification, status: .UnRead, datetime: "2:20 3/11/2019", content: "Trong vòng 15 phút nữa giữ chỗ EC19050212345 của bạn sẽ bị vô hiệu hóa. Gia hạn ngay để tiếp tục giữ chỗ hoặc gửi xe đúng giờ bạn nhé! ")
        return cell
    }
    
    override func didSelectTableView(item: Any, indexPath: IndexPath) {
        self.push(controller: NotificationDetailRouter.createModule(notificationID: 0, content: ""), animated: true)
    }
    
}

extension MyNotificationViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: LocalizableKey.Giveme.showLanguage)
    }
}
