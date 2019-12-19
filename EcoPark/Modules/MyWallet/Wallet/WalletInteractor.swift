//
//  WalletInteractor.swift
//  EcoPark
//
//  Created Ngoc Duong on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class WalletInteractor: WalletInteractorInputProtocol {

    weak var presenter: WalletInteractorOutputProtocol?
    
    func getWallet() {
        Provider.shared.userAPIService.getWallet(success: { (wallet) in
            guard let wallet = wallet else { return }
            self.presenter?.didGetWallet(wallet: wallet)
        }) { (error) in
            guard let error = error else { return }
            self.presenter?.didGetError(error: error)
        }
    }
    
    func getWalletHistory(offset: Int, showLoading: Bool) {
        if showLoading {
            ProgressView.shared.show()
        }
        Provider.shared.userAPIService.getWalletHistory(offset: offset, limit: 10, success: { (wallet) in
            ProgressView.shared.hide()
            guard let list = wallet?.historyWallet else { return }
            self.presenter?.didGetWalletHistory(listLog: list)
        }) { (error) in
            ProgressView.shared.hide()
            guard let error = error else { return }
            self.presenter?.didGetError(error: error)
        }
    }
    
    
}
