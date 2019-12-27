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

    @IBOutlet weak var vSearch: AppSearchTextField!
    @IBOutlet weak var tbBooking: UITableView!
    
	var presenter: HistoryPartnerBookingPresenterProtocol?

    var bookingReservation: Int = 0
    var historyParkingBooking: HistoryMyParkingEntity? {
        didSet {
            tbBooking.reloadData()
        }
    }
    
    var isCanLoadMore: Bool = false
    var isRefresh: Bool = false
    var refreshControl = UIRefreshControl()
    
	override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tbBooking.addSubview(refreshControl)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isRefresh = true
        historyParkingBooking = nil
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.getData()
        }
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
            self.presenter?.getHistoryParkingBooking(parkingID: parkingID&, status: "reservation", keyword: text, offset: 0, limit: limitLoad)
        }
        vSearch.tapToTextField = {
            self.isRefresh = true
            let text = self.vSearch.tfInput.text!
            print(text)
            var parkingID = UserDefaultHelper.shared.loginUserInfo?.infoParking?.id
            if parkingID == "" || parkingID == nil {
                parkingID = UserDefaultHelper.shared.loginUserInfo?.parkingID
            }
            self.presenter?.getHistoryParkingBooking(parkingID: parkingID&, status: "reservation", keyword: text, offset: 0, limit: limitLoad)
        }
    }
    
    private func getData() {
        var parkingID = UserDefaultHelper.shared.loginUserInfo?.infoParking?.id
        if parkingID == "" || parkingID == nil {
            parkingID = UserDefaultHelper.shared.loginUserInfo?.parkingID
        }
        presenter?.getHistoryParkingBooking(parkingID: parkingID&, status: "reservation", keyword: "", offset: 0, limit: limitLoad)
    }
    
    @objc func refresh() {
        getData()
        isRefresh = true
        self.refreshControl.endRefreshing()
    }
}

extension HistoryPartnerBookingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func configTableView() {
        tbBooking.delegate = self
        tbBooking.dataSource = self
        tbBooking.separatorStyle = .none
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
        self.push(controller: HistoryPartnerDetailBookingRouter.createModule(parkingID: historyParkingBooking?.booking[indexPath.item].parking_id ?? "", bookingID: historyParkingBooking?.booking[indexPath.item].id ?? ""))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let count = historyParkingBooking?.booking.count else { return }
        if indexPath.item == count - 5 && isCanLoadMore {
            var parkingID = UserDefaultHelper.shared.loginUserInfo?.infoParking?.id
            if parkingID == "" || parkingID == nil {
                parkingID = UserDefaultHelper.shared.loginUserInfo?.parkingID
            }
            print("load more")
            presenter?.getHistoryParkingBooking(parkingID: parkingID&, status: "reservation", keyword: "", offset: count, limit: limitLoad)
        }
    }
}

extension HistoryPartnerBookingViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: LocalizableKey.booked.showLanguage + " (\(bookingReservation))")
    }
}

extension HistoryPartnerBookingViewController: HistoryPartnerBookingViewProtocol {
    func didGetHistoryParkingBooking(historyParking: HistoryMyParkingEntity?) {
        isCanLoadMore = historyParking?.booking.count == limitLoad
        if self.historyParkingBooking == nil || self.historyParkingBooking?.booking.count == 0 || isRefresh {
                isRefresh = false
                self.historyParkingBooking = historyParking
        } else {
            guard let booking = historyParking?.booking else { return }
            self.historyParkingBooking?.booking.append(contentsOf: booking)
            tbBooking.reloadData()
        }
    }
    
}
