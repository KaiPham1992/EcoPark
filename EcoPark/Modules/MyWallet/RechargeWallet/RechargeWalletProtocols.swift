//
//  RechargeWalletProtocols.swift
//  EcoPark
//
//  Created Henry on 11/5/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol RechargeWalletWireframeProtocol: class {

}
//MARK: Presenter -
protocol RechargeWalletPresenterProtocol: class {

    var interactor: RechargeWalletInteractorInputProtocol? { get set }
}

//MARK: Interactor -
protocol RechargeWalletInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol RechargeWalletInteractorInputProtocol: class {

    var presenter: RechargeWalletInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol RechargeWalletViewProtocol: class {

    var presenter: RechargeWalletPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}