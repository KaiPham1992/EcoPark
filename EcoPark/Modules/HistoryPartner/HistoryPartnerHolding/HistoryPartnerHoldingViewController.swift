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

    @IBOutlet weak var vSearch: AppSearchTextField!
    @IBOutlet weak var tbPartnerHolding: UITableView!
    
	var presenter: HistoryPartnerHoldingPresenterProtocol?

    var number_place: String = "0"
    var parkedNumber: Int = 0
    var historyParkingHolding: HistoryMyParkingEntity? {
        didSet {
            tbPartnerHolding.reloadData()
        }
    }
    var historyBookingParkingResponse: HistoryBookingParkingResponse?
    var refreshControl = UIRefreshControl()
    var isCanLoadMore: Bool = false
    var isRefresh: Bool = false
    
	override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tbPartnerHolding.addSubview(refreshControl)
    }

    override func setUpViews() {
        super.setUpViews()
        vSearch.setTitleAndPlaceHolder(icon: nil, placeHolder: LocalizableKey.searchNumberCar.showLanguage)
        
        vSearch.actionSearch = { text in
            self.isRefresh = true
            var parkingID = UserDefaultHelper.shared.loginUserInfo?.infoParking?.id
            if parkingID == "" || parkingID == nil {
                parkingID = UserDefaultHelper.shared.loginUserInfo?.parkingID
            }
            self.presenter?.getHistoryReservation(parkingID: parkingID&, status: "checked_in", keyword: text, offset: 0, limit: limitLoad)
        }
        
        vSearch.tapToTextField = {
            self.isRefresh = true
            let text = self.vSearch.tfInput.text!
            var parkingID = UserDefaultHelper.shared.loginUserInfo?.infoParking?.id
            if parkingID == "" || parkingID == nil {
                parkingID = UserDefaultHelper.shared.loginUserInfo?.parkingID
            }
            self.presenter?.getHistoryReservation(parkingID: parkingID&, status: "checked_in", keyword: text, offset: 0, limit: limitLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isRefresh = true
        historyParkingHolding = nil
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.getData()
        }

        
    }
    
    private func getData() {
        var parkingID = UserDefaultHelper.shared.loginUserInfo?.infoParking?.id
        if parkingID == "" || parkingID == nil {
            parkingID = UserDefaultHelper.shared.loginUserInfo?.parkingID
        }
        
        presenter?.getHistoryReservation(parkingID: parkingID&, status: "checked_in", keyword: "", offset: 0, limit: limitLoad)
    }
    
    @objc func refresh() {
        getData()
        isRefresh = true
        self.refreshControl.endRefreshing()
    }
    
    @objc func btnCheckOutTapped(sender: UIButton) {
        
        let receivables = historyParkingHolding?.booking[sender.tag].receivables?.toCurrencyNoVND
        let vehicleType = historyParkingHolding?.booking[sender.tag].vehicleName
        let vehicleNumber = historyParkingHolding?.booking[sender.tag].license_plates ?? ""
        let checkoutNumber = historyParkingHolding?.booking[sender.tag].code ?? ""
        let bookingID = historyParkingHolding?.booking[sender.tag].id
        let code = historyParkingHolding?.booking[sender.tag].code
        let licensePlates = historyParkingHolding?.booking[sender.tag].license_plates
        
//        if historyParkingHolding?.booking[sender.tag].number_hours ?? 0 >= 2 {
            PopUpHelper.shared.showPartnerCheckOut(width: tbPartnerHolding.frame.width, price: receivables ?? "0", vehicleType: vehicleType&, vehicleNumber: vehicleNumber, checkOutNumber: checkoutNumber, completionCancel: nil, completionCheckAgain: {
                self.push(controller: HistoryPartnerDetailCheckAgainRouter.createModule(parkingID: self.historyParkingHolding?.booking[sender.tag].parking_id ?? "", bookingID: self.historyParkingHolding?.booking[sender.tag].id ?? ""))
            }) {
                self.presenter?.checkoutParking(bookingID: bookingID&, code: code&, licensePlates: licensePlates&)
            }
//        } else {
//            PopUpHelper.shared.showMessage(message: LocalizableKey.check2Hours.showLanguage, width: 350, completion: {})
//        }
        
        
    }
}

extension HistoryPartnerHoldingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func configTableView() {
        tbPartnerHolding.delegate = self
        tbPartnerHolding.dataSource = self
        tbPartnerHolding.separatorStyle = .none
        tbPartnerHolding.registerXibFile(HistoryParnerCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyParkingHolding?.booking.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(HistoryParnerCell.self)
        cell.setDataHistory(historyParking: historyParkingHolding?.booking[indexPath.item])
        cell.btnStatus.tag = indexPath.item
        cell.btnStatus.addTarget(self, action: #selector(btnCheckOutTapped), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(controller: HistoryPartnerDetailCheckinRouter.createModule(parkingID: historyParkingHolding?.booking[indexPath.item].parking_id ?? "", bookingID: historyParkingHolding?.booking[indexPath.item].id ?? ""))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let count = historyParkingHolding?.booking.count else { return }
        if indexPath.item == count - 5 && isCanLoadMore {
            var parkingID = UserDefaultHelper.shared.loginUserInfo?.infoParking?.id
            if parkingID == "" || parkingID == nil {
                parkingID = UserDefaultHelper.shared.loginUserInfo?.parkingID
            }
            print("load more")
            presenter?.getHistoryReservation(parkingID: parkingID&, status: "checked_in", keyword: "", offset: count, limit: limitLoad)
        }
    }
}

extension HistoryPartnerHoldingViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: LocalizableKey.holding.showLanguage + " (\(parkedNumber)/\(number_place))")
    }
    
}

extension HistoryPartnerHoldingViewController: HistoryPartnerHoldingViewProtocol {
    
    func didChangeStatusCheckout(historyCheckout: BookingDetailEntity) {
        self.push(controller: HistoryPartnerDetailCheckoutRouter.createModule(bookingID: historyCheckout.id ?? "", parkingID: historyCheckout.parking_id ?? ""))
    }
    
    func didGetHistoryReservation(historyParking: HistoryMyParkingEntity?) {
        self.historyParkingHolding = historyParking
        isCanLoadMore = historyParking?.booking.count == limitLoad
        if self.historyParkingHolding == nil || self.historyParkingHolding?.booking.count == 0 || isRefresh {
                isRefresh = false
                self.historyParkingHolding = historyParking
        } else {
            guard let booking = historyParking?.booking else { return }
            self.historyParkingHolding?.booking.append(contentsOf: booking)
            tbPartnerHolding.reloadData()
        }
    }
    
    func didCheckout(historyParkingDetail: HistoryBookingParkingResponse?) {
        presenter?.changeStatusCheckout(booking: historyParkingDetail?.id ?? "", bonus: "\(historyParkingDetail?.bonus ?? 0)", plus_wallet_boss: "\(historyParkingDetail?.plus_wallet_boss ?? "0")", parking_price: "\(historyParkingDetail?.parking_price ?? 0)", payment_wallet: "\(historyParkingDetail?.payment_wallet ?? 0)")
        self.historyBookingParkingResponse = historyParkingDetail
        
    }
}
