//
//  WalletPresenter.swift
//  EcoPark
//
//  Created Ngoc Duong on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class WalletPresenter: WalletPresenterProtocol, WalletInteractorOutputProtocol {

    weak private var view: WalletViewProtocol?
    var interactor: WalletInteractorInputProtocol?
    private let router: WalletWireframeProtocol

    var canLoadMore: Bool = false
    var listWalletHistory : [HistoryWallet] = [HistoryWallet]()
    
    init(interface: WalletViewProtocol, interactor: WalletInteractorInputProtocol?, router: WalletWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: Get wallet history
    func getWalletHistory(startDate: String, toDate: String, showLoading: Bool) {
        self.interactor?.getWalletHistory(startDate: startDate, toDate: toDate, offset: listWalletHistory.count, showLoading: showLoading)
    }
    
    func didGetWalletHistory(listLog: [HistoryWallet]) {
        if listLog.count == 10 {
            canLoadMore = true
        } else {
            canLoadMore = false
        }
        
        listWalletHistory.append(contentsOf: listLog)
        self.view?.didGetWalletHistory(listLog: listWalletHistory)
    }
    
    // MARK: Get wallet
    func getWallet() {
        self.interactor?.getWallet()
    }
    
    func didGetWallet(wallet: WalletEntity) {
        self.view?.didGetWallet(wallet: wallet)
    }
    
    func didGetError(error: APIError) {
        self.view?.didGetError(error: error)
    }

}
