//
//  SignUpPartnerStep3Protocols.swift
//  EnglishApp
//
//  Created Tu DV on 10/31/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

//MARK: Wireframe -
protocol SignUpPartnerStep3WireframeProtocol: class {

}
//MARK: Presenter -
protocol SignUpPartnerStep3PresenterProtocol: class {

    var interactor: SignUpPartnerStep3InteractorInputProtocol? { get set }
    
    func bossRegister(param: BossRegisterParam)
    func uploadImage(image: UIImage)
}

//MARK: Interactor -
protocol SignUpPartnerStep3InteractorOutputProtocol: class {

    /* Interactor -> Presenter */
}

protocol SignUpPartnerStep3InteractorInputProtocol: class {

    var presenter: SignUpPartnerStep3InteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
}

//MARK: View -
protocol SignUpPartnerStep3ViewProtocol: class {

    var presenter: SignUpPartnerStep3PresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    
    func didBossRegister(parkingInfo: ParkingInfoEntity?)
    func didUploadImage(photo: PhotoEntity?)
}
