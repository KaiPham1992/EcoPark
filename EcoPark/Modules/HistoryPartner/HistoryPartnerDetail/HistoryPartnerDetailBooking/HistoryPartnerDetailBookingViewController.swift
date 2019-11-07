//
//  HistoryPartnerDetailBookingViewController.swift
//  EcoPark
//
//  Created Tu DV on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryPartnerDetailBookingViewController: BaseViewController, HistoryPartnerDetailBookingViewProtocol {

    @IBOutlet weak var lbID: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var tbHoldingDetail: UITableView!
    
	var presenter: HistoryPartnerDetailBookingPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigation()
        configTableView()
    }
}

extension HistoryPartnerDetailBookingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func configTableView() {
        tbHoldingDetail.dataSource = self
        tbHoldingDetail.delegate = self
        
        tbHoldingDetail.registerXibFile(TimeParkingCell.self)
        tbHoldingDetail.registerXibFile(UserInfoCell.self)
        tbHoldingDetail.registerXibFile(PriceCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let timeHoldingCell = tableView.dequeueTableCell(TimeParkingCell.self)
            
            return timeHoldingCell
        case 1:
            let userInfoCell = tableView.dequeueTableCell(UserInfoCell.self)
            
            return userInfoCell
        default:
            let priceCell = tableView.dequeueTableCell(PriceCell.self)
            
            return priceCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 230
        case 1:
            return 145
        default:
            return 145
        }
    }
}