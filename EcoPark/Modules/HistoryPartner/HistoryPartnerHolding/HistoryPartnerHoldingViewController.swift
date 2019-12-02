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
    
    
	override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        
    }

    override func setUpViews() {
        super.setUpViews()
        vSearch.setTitleAndPlaceHolder(icon: nil, placeHolder: LocalizableKey.searchNumberCar.showLanguage)
        vSearch.tapToTextField = {
            let keyword = self.vSearch.tfInput.text!
            guard let parkingID = UserDefaultHelper.shared.loginUserInfo?.parkingID else { return }
            self.presenter?.getHistoryReservation(parkingID: parkingID, status: "reservation", keyword: keyword)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    private func getData() {
        guard let parkingID = UserDefaultHelper.shared.loginUserInfo?.parkingID else { return }
        presenter?.getHistoryReservation(parkingID: parkingID, status: "reservation", keyword: "")
    }
    
    @objc func btnCheckOutTapped(sender: UIButton) {
        
        let price = historyParkingReservation?.booking[sender.tag].money_paid ?? 0
        let vehicleType = "4"//historyParkingReservation?.booking[indexTap]
        let vehicleNumber = historyParkingReservation?.booking[sender.tag].license_plates ?? ""
        let checkoutNumber = historyParkingReservation?.booking[sender.tag].code ?? ""
        let bookingID = historyParkingReservation?.booking[sender.tag].id
        let code = historyParkingReservation?.booking[sender.tag].code
        let licensePlates = historyParkingReservation?.booking[sender.tag].license_plates
        
        PopUpHelper.shared.showPartnerCheckOut(width: tbPartnerHolding.frame.width, price: price, vehicleType: vehicleType, vehicleNumber: vehicleNumber, checkOutNumber: checkoutNumber, completionCancel: nil, completionCheckAgain: {
            self.push(controller: HistoryPartnerDetailCheckinRouter.createModule(parkingID: self.historyParkingReservation?.booking[sender.tag].parking_id ?? "", bookingID: self.historyParkingReservation?.booking[sender.tag].id ?? ""))
        }) {
            self.presenter?.checkoutParking(bookingID: bookingID&, code: code&, licensePlates: licensePlates&)
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
        self.push(controller: HistoryPartnerDetailCheckinRouter.createModule(parkingID: historyParkingReservation?.booking[indexPath.item].parking_id ?? "", bookingID: historyParkingReservation?.booking[indexPath.item].id ?? ""))
    }
}

extension HistoryPartnerHoldingViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        let place = historyParkingReservation?.number_place
        let reservation = historyParkingReservation?.reservation_number
        return IndicatorInfo(title: LocalizableKey.holding.showLanguage + " (\(reservation ?? 0)/\(place ?? 0))")
    }
    
}

extension HistoryPartnerHoldingViewController: HistoryPartnerHoldingViewProtocol {
    func didGetHistoryReservation(historyParking: HistoryMyParkingEntity?) {
        self.historyParkingReservation = historyParking
        
    }
    
    func didCheckout(historyParkingDetail: HistoryBookingParkingResponse?) {
        self.push(controller: HistoryPartnerDetailCheckoutRouter.createModule(historyParkingDetail: historyParkingDetail))
    }
}
