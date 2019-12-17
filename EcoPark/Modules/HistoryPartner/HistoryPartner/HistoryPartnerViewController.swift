//
//  HistoryPartnerViewController.swift
//  EcoPark
//
//  Created Tu DV on 11/4/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class HistoryPartnerViewController: UIViewController, HistoryPartnerViewProtocol {

    @IBOutlet weak var tbHistoryParking: UITableView!
    
    var historyParking: HistoryMyParkingEntity? {
        didSet{
            tbHistoryParking.reloadData()
        }
    }
    
	var presenter: HistoryPartnerPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let parkingID = UserDefaultHelper.shared.loginUserInfo?.infoParking?.id else { return }
        presenter?.getHistoryParking(parkingID: parkingID, status: "history", keyword: "")
    }
    
    
    func didGetHistoryParking(historyParking: HistoryMyParkingEntity?) {
        self.historyParking = historyParking
    }
}

extension HistoryPartnerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func configTableView() {
        tbHistoryParking.delegate = self
        tbHistoryParking.dataSource = self
        
        tbHistoryParking.registerXibFile(HistoryParnerCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyParking?.booking.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(HistoryParnerCell.self)
        let status = historyParking?.booking[indexPath.item].status
        cell.setDataHistoryParking(status: status&)
        cell.setDataHistory(historyParking: historyParking?.booking[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookingParking = HistoryBookingParkingResponse()
        let bookingID = historyParking?.booking[indexPath.item].id
         bookingParking.id = bookingID
        let vc = DetailParkingRouter.createModule(bookingParking: bookingParking)
        self.push(controller: vc)
    }
}

extension HistoryPartnerViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: LocalizableKey.history.showLanguage)
    }
}
