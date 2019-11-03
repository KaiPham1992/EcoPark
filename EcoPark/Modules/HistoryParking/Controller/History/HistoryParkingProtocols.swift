//
//  HistoryParkingProtocols.swift
//  EcoPark
//
//  Created Steve on 11/1/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol HistoryParkingWireframeProtocol: class {

}
//MARK: Presenter -
protocol HistoryParkingPresenterProtocol: class {

    var interactor: HistoryParkingInteractorInputProtocol? { get set }
}

//MARK: Interactor -
protocol HistoryParkingInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol HistoryParkingInteractorInputProtocol: class {

    var presenter: HistoryParkingInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol HistoryParkingViewProtocol: class {

    var presenter: HistoryParkingPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
