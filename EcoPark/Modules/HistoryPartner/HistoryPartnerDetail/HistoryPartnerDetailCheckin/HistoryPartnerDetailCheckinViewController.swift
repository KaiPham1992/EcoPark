//
//  HistoryPartnerDetailCheckinViewController.swift
//  EcoPark
//
//  Created Tu DV on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryPartnerDetailCheckinViewController: BaseViewController, HistoryPartnerDetailCheckinViewProtocol {
    

    @IBOutlet weak var lbID: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var tbCheckInDetail: UITableView!
    @IBOutlet weak var btnCheckOut: UIButton!
    @IBOutlet weak var btnScanQR: UIButton!
    
    var parkingID: String = ""
    var bookingID: String = ""
    
    var historyParkingDetail: HistoryBookingParkingResponse? {
        didSet {
            tbCheckInDetail.reloadData()
        }
    }
    
    
	var presenter: HistoryPartnerDetailCheckinPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        addBackToNavigation()
        setTitleNavigation(title: "Chi tiết giao dịch")
        configTableView()
        btnCheckOut.setBorder(borderWidth: 0.5, borderColor: AppColor.color_0_129_255, cornerRadius: 5)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getHistoryParkingDetailCheckIn(parkingID: parkingID, bookingID: bookingID)
    }
    
    
    @IBAction func btnCheckOutTapped() {
        
        let price = historyParkingDetail?.money_paid ?? 0
        let vehicleType = "4"//historyParkingReservation?.booking[indexTap]
        let vehicleNumber = historyParkingDetail?.license_plates ?? ""
        let checkoutNumber = historyParkingDetail?.code ?? ""
        let bookingID = historyParkingDetail?.id
        let code = historyParkingDetail?.code
        let licensePlates = historyParkingDetail?.license_plates
        PopUpHelper.shared.showPartnerCheckOut(width: tbCheckInDetail.frame.width, price: Double(price), vehicleType: vehicleType, vehicleNumber: vehicleNumber, checkOutNumber: checkoutNumber, completionCancel: nil, completionCheckAgain: {
            
        }) {
            self.presenter?.checkoutParking(bookingID: bookingID&, code: code&, licensePlates: licensePlates&)
        }
    }
    
    @IBAction func btnScanQRTapped() {
//        self.push(controller: HistoryPartnerQRScannerRouter.createModule())
        let vc = AppQRScanerViewController.createModule(isCheckIn: false)
        vc.completionCode = { code in
            
            guard let qrcode = code as? [String] else { return }
            if qrcode.count > 5 {
                print(qrcode)
                let bookingID = qrcode[2]
                let code = qrcode[4]
                let licensePlates = qrcode[3]
                self.presenter?.checkoutParking(bookingID: bookingID, code: code, licensePlates: licensePlates)
            }
        }
        self.push(controller: vc)
    }
    
    func didGetData(historyParkingDetail: HistoryBookingParkingResponse?) {
        self.historyParkingDetail = historyParkingDetail
    }
    
    func didCheckout(historyParkingDetail: HistoryBookingParkingResponse?) {
        self.push(controller: HistoryPartnerDetailCheckoutRouter.createModule(historyParkingDetail: historyParkingDetail))
    }
}

extension HistoryPartnerDetailCheckinViewController: UITableViewDataSource, UITableViewDelegate {
    
    func configTableView() {
        tbCheckInDetail.dataSource = self
        tbCheckInDetail.delegate = self
        
        tbCheckInDetail.registerXibFile(TimeParkingCell.self)
        tbCheckInDetail.registerXibFile(UserInfoCell.self)
        tbCheckInDetail.registerXibFile(PriceCell.self)
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
            let priceCell = tableView.dequeueTableCell(PriceCell.self)
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
            return 145
        }
    }
}
