//
//  SystemNotificationViewController.swift
//  EcoPark
//
//  Created Henry on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class SystemNotificationViewController: ListManagerVC, SystemNotificationViewProtocol {

	var presenter: SystemNotificationPresenterProtocol?

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
        cell.displayData(type: .SystemNotification, status: .IsRead, datetime: "2:20 3/11/2019", content: "Nếu hôm nay bạn bỏ lỡ sẽ không có cơ hội lần sau. SĂN NGAY CƠ HỘI ngàn vàng cùng 9 lượng vàng SJC. Bỏ 5 giây còn hơn nuối tiếc 1 đời")
        return cell
    }
    
    override func didSelectTableView(item: Any, indexPath: IndexPath) {
        self.push(controller: NotificationDetailRouter.createModule(), animated: true)
    }

}

extension SystemNotificationViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Hệ thống")
    }
}