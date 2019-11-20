//
//  HistoryPartnerBookingViewController.swift
//  EcoPark
//
//  Created Tu DV on 11/2/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class HistoryPartnerBookingViewController: BaseViewController {

    @IBOutlet weak var vSearch: AppSearchBar!
    @IBOutlet weak var tbBooking: UITableView!
    
	var presenter: HistoryPartnerBookingPresenterProtocol?

    var historyParkingBooking: HistoryMyParkingEntity? {
        didSet {
            tbBooking.reloadData()
        }
    }
    
	override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    override func setUpViews() {
        super.setUpViews()
        vSearch.setTitleAndPlaceHolder(icon: nil, placeHolder: "Tìm theo biển số xe")
        vSearch.tapToTextField = {
            let keyword = self.vSearch.tfInput.text!
            self.presenter?.getHistoryParkingBooking(parkingID: "2", status: "checked_in", keyword: keyword)
        }
    }
    
    private func getData() {
        presenter?.getHistoryParkingBooking(parkingID: "2", status: "checked_in", keyword: "")
    }
}

extension HistoryPartnerBookingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func configTableView() {
        tbBooking.delegate = self
        tbBooking.dataSource = self
        
        tbBooking.registerXibFile(HistoryParnerCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyParkingBooking?.booking.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(HistoryParnerCell.self)
        cell.setDataBookingHistory()
        cell.setDataHistory(historyParking: historyParkingBooking?.booking[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(controller: HistoryPartnerDetailBookingRouter.createModule())
    }
}

extension HistoryPartnerBookingViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Đã đặt chỗ (0)")
    }
}

extension HistoryPartnerBookingViewController: HistoryPartnerBookingViewProtocol {
    func didGetHistoryParkingBooking(historyParking: HistoryMyParkingEntity?) {
        self.historyParkingBooking = historyParking
    }
    
}
