//
//  WalletViewController.swift
//  EcoPark
//
//  Created Ngoc Duong on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class WalletViewController: BaseViewController {

    @IBOutlet weak var fromToDatePicker: FromToDatePicker!
    @IBOutlet weak var tbWallet: UITableView!
    @IBOutlet weak var lbWalletMoney: UILabel!
    
	var presenter: WalletPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        addMenu()
        setTitleNavigation(title: "Ví Tiền")
    }
    
    override func setUpViews() {
        super.setUpViews()
        configTableView()
        
        tbWallet.backgroundColor = .clear
        setWalletMoney(money: 182000)
    }
    
    func setWalletMoney(money: Int) {
        let money = money.description.formatNumber(type: ",")
        let attr1 = "\(money)".toAttributedString(color: AppColor.color_0_129_255, font: AppFont.fontBold18, isUnderLine: false)
        let attr2 = " VND".description.toAttributedString(color: AppColor.white, font: AppFont.fontRegular18, isUnderLine: false)
                
        let attr = NSMutableAttributedString()
        attr.append(attr1)
        attr.append(attr2)
        lbWalletMoney.attributedText = attr
    }
    
    @IBAction func btnRechargeTapped() {
        let vc = RechargeWalletRouter.createModule()
        self.push(controller: vc)
    }
    
}

extension WalletViewController: WalletViewProtocol {
    func didGetWallet(wallet: WalletEntity) {
        setWalletMoney(money: wallet.wallet ?? 0)
    }
    
    func didGetError(error: APIError) {
        printError(message: error.message)
    }
}

extension WalletViewController: UITableViewDataSource, UITableViewDelegate {
    
    func configTableView() {
        tbWallet.dataSource = self
        tbWallet.delegate = self
        tbWallet.registerXibFile(WalletCell.self)
        tbWallet.estimatedRowHeight = 200
        tbWallet.rowHeight = UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(WalletCell.self)
        cell.displayData(isPlus: true, dateTime: "03/05/2019", price: 1000000, content: "Thanh toán phí đỗ xe EC19050512345. Cám ơn bạn đã sử dụng dịch vụ của EcoParking.")
        return cell
    }

}
