//
//  HistoryPartnerDetailCheckoutViewController.swift
//  EcoPark
//
//  Created Tu DV on 11/20/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryPartnerDetailCheckoutViewController: BaseViewController, HistoryPartnerDetailCheckoutViewProtocol {

    @IBOutlet weak var lbID: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var tbCheckoutDetail: UITableView!
    
    var presenter: HistoryPartnerDetailCheckoutPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackToNavigation()
        setTitleNavigation(title: "Chi tiết giao dịch")
        configTableView()
    }
}

extension HistoryPartnerDetailCheckoutViewController: UITableViewDataSource, UITableViewDelegate {
    
    func configTableView() {
        tbCheckoutDetail.dataSource = self
        tbCheckoutDetail.delegate = self
        
        tbCheckoutDetail.registerXibFile(TimeParkingCell.self)
        tbCheckoutDetail.registerXibFile(UserInfoCell.self)
        tbCheckoutDetail.registerXibFile(PriceCheckoutCell.self)
        tbCheckoutDetail.registerXibFile(OtherPriceCheckoutCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let timeHoldingCell = tableView.dequeueTableCell(TimeParkingCell.self)
            
            return timeHoldingCell
        case 1:
            let userInfoCell = tableView.dequeueTableCell(UserInfoCell.self)
            
            return userInfoCell
        case 2:
            let priceCell = tableView.dequeueTableCell(PriceCheckoutCell.self)
            
            return priceCell
        default:
            let otherPriceCell = tableView.dequeueTableCell(OtherPriceCheckoutCell.self)
            
            return otherPriceCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 230
        case 1:
            return 145
        case 2:
            return 230
        default:
            return 170
        }
    }
}
