//
//  HistoryPartnerDetailCheckAgainViewController.swift
//  EcoPark
//
//  Created Tu DV on 12/29/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryPartnerDetailCheckAgainViewController: BaseViewController, HistoryPartnerDetailCheckAgainViewProtocol {
    

    @IBOutlet weak var lbID: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var tbCheckInDetail: UITableView!
    @IBOutlet weak var btnCheckOut: UIButton!
    
    var parkingID: String = ""
    var bookingID: String = ""
    
    var historyParkingDetail: HistoryBookingParkingResponse? {
        didSet {
            tbCheckInDetail.reloadData()
        }
    }
    
    
    var presenter: HistoryPartnerDetailCheckAgainPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.titleHistoryDetail.showLanguage)
        configTableView()
        btnCheckOut.setBorder(borderWidth: 0.5, borderColor: AppColor.color_0_129_255, cornerRadius: 5)
        lbStatus.text = LocalizableKey.checked_in.showLanguage
        btnCheckOut.setTitle(LocalizableKey.agreeCheckout.showLanguage, for: .normal)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getHistoryParkingDetailCheckIn(parkingID: parkingID, bookingID: bookingID)
    }
    
    
    @IBAction func btnCheckOutTapped() {
        
        
        let bookingID = historyParkingDetail?.id
        let code = historyParkingDetail?.code
        let licensePlates = historyParkingDetail?.license_plates
        
            self.presenter?.checkoutParking(bookingID: bookingID&, code: code&, licensePlates: licensePlates&)
    }
    
    
    func didGetData(historyParkingDetail: HistoryBookingParkingResponse?) {
        self.historyParkingDetail = historyParkingDetail
        lbID.text = historyParkingDetail?.code&
    }
    
    func didCheckout(historyParkingDetail: HistoryBookingParkingResponse?) {
        self.historyParkingDetail = historyParkingDetail
        presenter?.changeStatusCheckout(bookingID: historyParkingDetail?.id ?? "", bonus: "\(historyParkingDetail?.bonus ?? 0)", plus_wallet_boss: "\(historyParkingDetail?.plus_wallet_boss ?? "0")", parking_price: "\(historyParkingDetail?.parking_price ?? 0)", payment_wallet: "\(historyParkingDetail?.payment_wallet ?? 0)")
        
    }
    
    func didChangeStatusCheckout(historyCheckout: BookingDetailEntity?) {
        self.push(controller: HistoryPartnerDetailCheckoutRouter.createModule(bookingID: historyCheckout?.id ?? "", parkingID: historyCheckout?.parking_id ?? ""))
    }
}

extension HistoryPartnerDetailCheckAgainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func configTableView() {
        tbCheckInDetail.dataSource = self
        tbCheckInDetail.delegate = self
        
        tbCheckInDetail.registerXibFile(TimeParkingCell.self)
        tbCheckInDetail.registerXibFile(UserInfoCell.self)
        tbCheckInDetail.registerXibFile(PriceCheckoutCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let timeHoldingCell = tableView.dequeueTableCell(TimeParkingCell.self)
            timeHoldingCell.setData(historyParkingDetail: historyParkingDetail)
            return timeHoldingCell
        case 1:
            let userInfoCell = tableView.dequeueTableCell(UserInfoCell.self)
            userInfoCell.setData(historyParkingDetail: historyParkingDetail)
            return userInfoCell
        default:
            let priceCell = tableView.dequeueTableCell(PriceCheckoutCell.self)
            priceCell.setData(historyParkingDetail: historyParkingDetail)
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
            return 230
        }
    }
}

