//
//  HomeFindProtocols.swift
//  EnglishApp
//
//  Created Ngoc Duong on 10/26/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol HomeFindWireframeProtocol: class {

}
//MARK: Presenter -
protocol HomeFindPresenterProtocol: class {

    var interactor: HomeFindInteractorInputProtocol? { get set }
    func searchPlaceByString(text: String)
}

//MARK: Interactor -
protocol HomeFindInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol HomeFindInteractorInputProtocol: class {

    var presenter: HomeFindInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol HomeFindViewProtocol: class {

    var presenter: HomeFindPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
