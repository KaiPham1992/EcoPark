//
//  SignUpPartnerStep2ViewController.swift
//  EnglishApp
//
//  Created Tu DV on 10/30/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SignUpPartnerStep2ViewController: BaseViewController, SignUpPartnerStep2ViewProtocol {

    @IBOutlet weak var vStep: PartnerStepView!
    @IBOutlet weak var lbParking: UILabel!
    @IBOutlet weak var vParkingName: AppTextField!
    @IBOutlet weak var vParkingType: AppDropDown!
    @IBOutlet weak var vParkingCapacity: AppTextField!
    @IBOutlet weak var vParkingAddress: AppTextView!
    @IBOutlet weak var vOpen: AppTextField!
    @IBOutlet weak var vClose: AppTextField!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var vPriceAHours: AppTextField!
    @IBOutlet weak var vPriceCombo: AppTextField!
    @IBOutlet weak var lbLicense: UILabel!
    @IBOutlet weak var vTaxCode: AppTextField!
    @IBOutlet weak var lbFrontPhoto: UILabel!
    @IBOutlet weak var lbBacksidePhoto: UILabel!
    @IBOutlet weak var imgFrontPhoto: UIImageView!
    @IBOutlet weak var imgBacksidePhoto: UIImageView!
    @IBOutlet weak var btnDeletePhotoFront: UIButton!
    @IBOutlet weak var btnDeletePhotoBacksite: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lbError: UILabel!
	var presenter: SignUpPartnerStep2PresenterProtocol?

    var param: BossRegisterParam?
    
	override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        setTitleNavigation(title: LocalizableKey.MenuSignUpPartner.showLanguage)
        addBackToNavigation()
        vStep.setStep2()
        lbParking.text = LocalizableKey.parkingInfo.showLanguage.uppercased()
        lbPrice.text = LocalizableKey.parkingPrice.showLanguage.uppercased()
        lbLicense.text = LocalizableKey.parkingLicense.showLanguage.uppercased()
        
        vParkingName.setTitleAndPlaceHolder(title: LocalizableKey.parkingName.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vParkingType.setTitleAndPlaceHolder(title: LocalizableKey.parkingType.showLanguage, placeHolder: LocalizableKey.select.showLanguage)
        vParkingCapacity.setTitleAndPlaceHolder(title: LocalizableKey.parkingCapacity.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vParkingAddress.setTitleAndPlaceHolder(title: LocalizableKey.parkingAddress.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vParkingAddress.setPlaceHolder(placeHolder: LocalizableKey.enter.showLanguage)
        vOpen.setTitleAndPlaceHolder(title: LocalizableKey.parkingOpen.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vClose.setTitleAndPlaceHolder(title: LocalizableKey.parkingClose.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vPriceAHours.setTitleAndPlaceHolder(title: LocalizableKey.pirceAHours.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vPriceCombo.setTitleAndPlaceHolder(title: LocalizableKey.priceCombo.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vTaxCode.setTitleAndPlaceHolder(title: LocalizableKey.parkingTaxCode.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        
        lbFrontPhoto.text = LocalizableKey.photoFront.showLanguage
        lbBacksidePhoto.text = LocalizableKey.photoBackside.showLanguage
        btnNext.setTitle(LocalizableKey.next.showLanguage, for: .normal)
        btnDeletePhotoFront.isHidden = true
        btnDeletePhotoBacksite.isHidden = true
    }
    
    @IBAction func btnPhotoFrontTapped() {
        SelectPhotoCanCropPopUp.shared.showCropPicker(controller: self) { image in
            guard let _iamge = image else { return }
            self.imgFrontPhoto.image = _iamge
            self.btnDeletePhotoFront.isHidden = false
        }
    }
    
    @IBAction func btnPhotoBacksideTapped() {
        SelectPhotoCanCropPopUp.shared.showCropPicker(controller: self) { image in
            guard let _iamge = image else { return }
            self.imgBacksidePhoto.image = _iamge
            self.btnDeletePhotoBacksite.isHidden = false
        }
    }
    
    @IBAction func btnDeleteFrontTapped() {
        imgFrontPhoto.image = AppImage.imgAddImage
        self.btnDeletePhotoFront.isHidden = true
    }
    
    @IBAction func btnDeleteBacksideTapped() {
        imgBacksidePhoto.image = AppImage.imgAddImage
        self.btnDeletePhotoBacksite.isHidden = true
    }
    
    @IBAction func btnNextTapped() {
        self.push(controller: SignUpPartnerStep3Router.createModule())
    }
}

extension SignUpPartnerStep2ViewController {
    func validateInputData() -> Bool {
        if self.vParkingName.getText() == "" && self.vParkingType.tfInput.text == "" && self.vParkingCapacity.getText() == "" && self.vParkingAddress.tvInput.text == "" && vOpen.tfInput.text == "" && vClose.tfInput.text == "" && vPriceAHours.tfInput.text == "" && vPriceCombo.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.emptyLoginEmailPassword.showLanguage)
            return false
        }
        
        if self.vParkingName.getText() == "" {
            hideError(isHidden: false, message: LocalizableKey.errorNamePartner.showLanguage)
            return false
        }
        
        if self.vParkingType.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.errorIDNumber.showLanguage)
            return false
        }
        
        if self.vParkingCapacity.getText() == "" {
            hideError(isHidden: false, message: LocalizableKey.errorIssueBy.showLanguage)
            return false
        }
        
        if self.vParkingAddress.tvInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.errorDateBy.showLanguage)
            return false
        }
        
        
        hideError()
        return true
    }
        func hideError(isHidden: Bool = true, message: String? = nil){
            lbError.isHidden = isHidden
            lbError.text = message ?? ""
        }
}
