//
//  HomeProtocols.swift
//  EnglishApp
//
//  Created Ngoc Duong on 10/22/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol HomeWireframeProtocol: class {

}
//MARK: Presenter -
protocol HomePresenterProtocol: class {

    var interactor: HomeInteractorInputProtocol? { get set }
//    func getListPark()
    func getProfileUser()
}

//MARK: Interactor -
protocol HomeInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
//    func getListPark()
}

protocol HomeInteractorInputProtocol: class {

    var presenter: HomeInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol HomeViewProtocol: class {

    var presenter: HomePresenterProtocol?  { get set }

    /* Presenter -> ViewController */
//    func didGetListPark()
    func didGetProfileUser(user: UserEntity)
}
