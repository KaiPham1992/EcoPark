//
//  DetailTransactionCustomerViewController.swift
//  EcoPark
//
//  Created Steve on 11/9/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

enum CheckOut {
    case no
    case yes
}
class DetailTransactionCustomerViewController: ListManagerVC, DetailTransactionCustomerViewProtocol {

	var presenter: DetailTransactionCustomerPresenterProtocol?
    var checkout: CheckOut = .yes
    lazy var buttonCheckout : UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.setTitle("Cho phép check out", for: .normal)
        view.backgroundColor = AppColor.color_0_129_255
        view.titleLabel?.font = AppFont.fontRegular17
        return view
    }()
    
    override func setUpViews() {
        customTitle = "Chi tiết giao dịch"
        super.setUpViews()
        self.view.backgroundColor = .black
        self.tableView.backgroundColor = .clear
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        self.setLeadingAndTraling16pt()
        //add button scan QR
        if checkout == .yes {
            self.view.addSubview(buttonCheckout)
            buttonCheckout.fillHorizontalSuperview(constant: 16)
            buttonCheckout.heightAnchor.constraint(equalToConstant: 40).isActive = true
            buttonCheckout.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16).isActive = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.initLoadData(data: [0,1,2,3,4])
        }
    }
    
    override func registerTableView() {
        super.registerTableView()
        tableView.registerXibFile(RatingCell.self)
        tableView.registerXibFile(PriceAddMoneyCell.self)
        tableView.registerXibFile(UserInfoCell.self)
        tableView.registerXibFile(TimeParkingCell.self)
        tableView.registerXibFile(RealParkingCell.self)
        tableView.registerXibFile(HeaderTransactionCell.self)
    }
    
    override func cellForRowListManager(item: Any, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeue(TimeParkingCell.self, for: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeue(UserInfoCell.self, for: indexPath)
            return cell
        case 2:
            let cell = tableView.dequeue(PriceAddMoneyCell.self, for: indexPath)
            return cell
        case 3:
            let cell = tableView.dequeue(RealParkingCell.self, for: indexPath)
            return cell
        case 4:
            let cell = tableView.dequeue(RatingCell.self, for: indexPath)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueTableCell(HeaderTransactionCell.self)
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}