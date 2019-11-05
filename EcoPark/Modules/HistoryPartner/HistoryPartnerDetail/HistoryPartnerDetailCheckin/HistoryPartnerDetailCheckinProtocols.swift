//
//  HistoryPartnerDetailCheckinProtocols.swift
//  EcoPark
//
//  Created Tu DV on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol HistoryPartnerDetailCheckinWireframeProtocol: class {

}
//MARK: Presenter -
protocol HistoryPartnerDetailCheckinPresenterProtocol: class {

    var interactor: HistoryPartnerDetailCheckinInteractorInputProtocol? { get set }
}

//MARK: Interactor -
protocol HistoryPartnerDetailCheckinInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol HistoryPartnerDetailCheckinInteractorInputProtocol: class {

    var presenter: HistoryPartnerDetailCheckinInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol HistoryPartnerDetailCheckinViewProtocol: class {

    var presenter: HistoryPartnerDetailCheckinPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
