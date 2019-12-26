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
    
    @IBOutlet weak var lbBalance: UILabel!
    @IBOutlet weak var btnRecharge: UIButton!
    
    let refreshControl = UIRefreshControl()
	var presenter: WalletPresenterProtocol?
    var listWalletHistory : [HistoryWallet] = [HistoryWallet]() {
        didSet {
            tbWallet.reloadData()
        }
    }
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        getWallet()
        getWalletHistory()
        addPullToRefresh()
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        addMenu()
        setTitleNavigation(title: LocalizableKey.titleWallet.showLanguage)

    }
    
    override func setUpViews() {
        super.setUpViews()
        configTableView()
        
        tbWallet.backgroundColor = .clear
        fromToDatePicker.setTitleAndPlaceHolder(fromTitle: LocalizableKey.from.showLanguage, toTitle: LocalizableKey.to.showLanguage)
        fromToDatePicker.fieldFrom.placeHolderColor = AppColor.color_0_129_255
        fromToDatePicker.fieldTo.placeHolderColor = AppColor.color_0_129_255
        
        lbBalance.text = LocalizableKey.titleBalance.showLanguage
        btnRecharge.setTitle(LocalizableKey.titleRecharge.showLanguage.uppercased(), for: .normal)
        
        fromToDatePicker.btnFrom.addTarget(self, action: #selector(btnFromTapped), for: .touchUpInside)
        fromToDatePicker.btnTo.addTarget(self, action: #selector(btnToTapped), for: .touchUpInside)
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
    
    @objc func btnFromTapped() {
        let popUp = ChooseDatePopUp()
        UIApplication.topViewController()?.view.endEditing(true)

        popUp.showPopUp(currentDate: fromToDatePicker.from, completionDate: { date in
            guard let date = date as? Date else {
                self.fromToDatePicker.from = nil
                self.fromToDatePicker.fieldFrom.text = ""
                self.fromToDatePicker.fieldFrom.placeholder = "dd/mm/yyyy"
                self.fromToDatePicker.fieldFrom.placeHolderColor = AppColor.color_0_129_255
                return
            }
            
            self.fromToDatePicker.from = date
            self.fromToDatePicker.fieldFrom.text = date.toString(dateFormat: AppDateFormat.ddMMYYYYTransaction)
            self.presenter?.listWalletHistory.removeAll()
            if self.fromToDatePicker.fieldTo.text == "" {
                self.presenter?.getWalletHistory(startDate: self.fromToDatePicker.fieldFrom.text!, toDate: Date().toString(dateFormat: AppDateFormat.ddMMYYYYTransaction), showLoading: true)
            } else {
                self.presenter?.getWalletHistory(startDate: self.fromToDatePicker.fieldFrom.text!, toDate: self.fromToDatePicker.fieldTo.text!, showLoading: true)
            }
            
        })
    }
    
    @objc func btnToTapped() {
        UIApplication.topViewController()?.view.endEditing(true)
        let popUp = ChooseDatePopUp()
        
        popUp.showPopUp(currentDate: fromToDatePicker.to, completionDate: { date in
            guard let date = date as? Date else {
                self.fromToDatePicker.to = nil
                self.fromToDatePicker.fieldTo.text = ""
                self.fromToDatePicker.fieldTo.placeholder = "dd/mm/yyyy"
                self.fromToDatePicker.fieldTo.placeHolderColor = AppColor.color_0_129_255
                return
            }
            self.fromToDatePicker.to = date
            self.fromToDatePicker.fieldTo.text = date.toString(dateFormat: AppDateFormat.ddMMYYYYTransaction)
            self.presenter?.listWalletHistory.removeAll()
            if self.fromToDatePicker.fieldFrom.text == "" {
                self.presenter?.getWalletHistory(startDate: "" , toDate: self.fromToDatePicker.fieldTo.text! , showLoading: true)
            } else {
                self.presenter?.getWalletHistory(startDate: self.fromToDatePicker.fieldFrom.text! , toDate: self.fromToDatePicker.fieldTo.text! , showLoading: true)
            }
            
        })
    }
    
    @IBAction func btnRechargeTapped() {
        let vc = RechargeWalletRouter.createModule()
        self.push(controller: vc)
    }
    
    private func addPullToRefresh(){
        refreshControl.tintColor = UIColor.white
        if #available(iOS 10.0, *) {
            self.tbWallet.refreshControl = refreshControl
        } else {
            self.tbWallet.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    @objc func pullToRefresh(){
        presenter?.listWalletHistory.removeAll()
        getWalletHistory(showLoading: false)
        refreshControl.endRefreshing()
    }
    
}

extension WalletViewController: WalletViewProtocol {
    // MARK: Get wallet
    func getWallet() {
        presenter?.getWallet()
    }
    
    func didGetWallet(wallet: WalletEntity) {
        setWalletMoney(money: wallet.wallet ?? 0)
    }
    
    // MARK: Get wallet history
    func getWalletHistory(showLoading: Bool = true) {
        presenter?.getWalletHistory(startDate: "", toDate: "", showLoading: showLoading)
    }
    
    func didGetWalletHistory(listLog: [HistoryWallet]) {
        self.listWalletHistory = listLog
    }
    
    // MARK: Did get error
    func didGetError(error: APIError) {
        showNoData()
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
        tbWallet.separatorStyle = .none 
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listWalletHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(WalletCell.self)
        let item = listWalletHistory[indexPath.row]
        if let price = item.price,
            let time = item.create_time_mi?.toString(dateFormat: .HHmmddMMyyyy),
            let content = item.content,
            let status = item.status {
            var isPlus = true
            if status.contains("minus") {
                isPlus = false
            }
            cell.displayData(isPlus: isPlus, dateTime: time, price: Int(price), content: content)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == listWalletHistory.count - 2 {
            if presenter?.canLoadMore == true {
                getWalletHistory(showLoading: false)
                // Loading icon
                let spiner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.white)
                spiner.startAnimating()
                spiner.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44)
                self.tbWallet.tableFooterView = spiner
                self.tbWallet.tableFooterView?.isHidden = false
            } else {
                self.tbWallet.tableFooterView?.isHidden = true
            }
        }
    }

}
