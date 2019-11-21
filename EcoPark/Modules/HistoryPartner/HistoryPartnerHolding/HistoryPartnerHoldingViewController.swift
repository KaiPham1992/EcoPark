//
//  HistoryPartnerHoldingViewController.swift
//  EcoPark
//
//  Created Tu DV on 11/2/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class HistoryPartnerHoldingViewController: BaseViewController {

    @IBOutlet weak var vSearch: AppSearchBar!
    @IBOutlet weak var tbPartnerHolding: UITableView!
    
	var presenter: HistoryPartnerHoldingPresenterProtocol?

    var historyParkingReservation: HistoryMyParkingEntity? {
        didSet {
            tbPartnerHolding.reloadData()
        }
    }
    
    var indexTap: Int = 0
    
	override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        
    }

    override func setUpViews() {
        super.setUpViews()
        vSearch.setTitleAndPlaceHolder(icon: nil, placeHolder: "Tìm theo biển số xe")
        vSearch.tapToTextField = {
            let keyword = self.vSearch.tfInput.text!
            self.presenter?.getHistoryReservation(parkingID: "2", status: "reservation", keyword: keyword)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    private func getData() {
        presenter?.getHistoryReservation(parkingID: "2", status: "reservation", keyword: "")
    }
    
    @objc func btnCheckOutTapped(sender: UIButton) {
        
        let price = historyParkingReservation?.booking[sender.tag].money_paid ?? 0
        let vehicleType = "4"//historyParkingReservation?.booking[indexTap]
        let vehicleNumber = historyParkingReservation?.booking[sender.tag].license_plates ?? ""
        let checkoutNumber = historyParkingReservation?.booking[sender.tag].code ?? ""
        
        PopUpHelper.shared.showPartnerCheckOut(width: tbPartnerHolding.frame.width, price: price, vehicleType: vehicleType, vehicleNumber: vehicleNumber, checkOutNumber: checkoutNumber, completionCancel: nil, completionCheckAgain: {
            self.push(controller: HistoryPartnerDetailCheckinRouter.createModule(parkingID: self.historyParkingReservation?.booking[sender.tag].parking_id ?? "", bookingID: self.historyParkingReservation?.booking[sender.tag].id ?? ""))
        }) {
            self.push(controller: HistoryPartnerDetailCheckoutRouter.createModule())
        }
    }
}

extension HistoryPartnerHoldingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func configTableView() {
        tbPartnerHolding.delegate = self
        tbPartnerHolding.dataSource = self
        
        tbPartnerHolding.registerXibFile(HistoryParnerCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyParkingReservation?.booking.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(HistoryParnerCell.self)
        cell.setDataHistory(historyParking: historyParkingReservation?.booking[indexPath.item])
        cell.btnStatus.tag = indexPath.item
        cell.btnStatus.addTarget(self, action: #selector(btnCheckOutTapped), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(controller: HistoryPartnerDetailCheckinRouter.createModule(parkingID: historyParkingReservation?.booking[indexTap].parking_id ?? "", bookingID: historyParkingReservation?.booking[indexTap].id ?? ""))
    }
}

extension HistoryPartnerHoldingViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        let place = historyParkingReservation?.number_place
        let reservation = historyParkingReservation?.reservation_number
        return IndicatorInfo(title: "Đang giữ (\(reservation ?? 0)/\(place ?? "0"))")
    }
}

extension HistoryPartnerHoldingViewController: HistoryPartnerHoldingViewProtocol {
    func didGetHistoryReservation(historyParking: HistoryMyParkingEntity?) {
        self.historyParkingReservation = historyParking
    }
}
