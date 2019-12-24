//
//  SignUpPartnerStep1ViewController.swift
//  EnglishApp
//
//  Created Tu DV on 10/29/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SignUpPartnerStep1ViewController: BaseViewController, SignUpPartnerStep1ViewProtocol {
    
    @IBOutlet weak var vStep: PartnerStepView!
    @IBOutlet weak var lbPartnerInfo: UILabel!
    @IBOutlet  weak var vPartnerName: AppTextField!
    @IBOutlet weak var vGender: AppDropDown!
    @IBOutlet weak var vBirthday: AppDateDropDown!
    @IBOutlet weak var vIDNumber: AppTextField!
    @IBOutlet weak var vIssuedBy: AppTextField!
    @IBOutlet weak var vDateBy: AppDateDropDown!
    @IBOutlet weak var vEmail: AppTextField!
    @IBOutlet weak var lbImage: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lbPhotoNotice: UILabel!
    @IBOutlet weak var lbFrontPhoto: UILabel!
    @IBOutlet weak var lbBacksidePhoto: UILabel!
    @IBOutlet weak var imgFrontPhoto: UIImageView!
    @IBOutlet weak var imgBacksidePhoto: UIImageView!
    @IBOutlet weak var btnDeletePhotoFront: UIButton!
    @IBOutlet weak var btnDeletePhotoBacksite: UIButton!
    @IBOutlet weak var lbError: UILabel!
    
    var presenter: SignUpPartnerStep1PresenterProtocol?
    
    var urlPhotoIDFront: String = ""
    var urlPhotoIDBackside: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupToHideKeyboardOnTapOnView()
    }
    
    private func setupUI() {
        addMenu()
        setTitleNavigation(title: LocalizableKey.MenuSignUpPartner.showLanguage)
        vStep.setStep1()
        lbPartnerInfo.text = LocalizableKey.partnerInfo.showLanguage.uppercased()
        vPartnerName.setTitleAndPlaceHolder(title: LocalizableKey.partnerName.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vGender.setTitleAndPlaceHolder(title: LocalizableKey.gender.showLanguage, placeHolder: LocalizableKey.select.showLanguage)
        vBirthday.setTitleAndPlaceHolder(title: LocalizableKey.birthday.showLanguage, placeHolder: LocalizableKey.select.showLanguage)
        vIDNumber.setTitleAndPlaceHolder(title: LocalizableKey.partnerID.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vIssuedBy.setTitleAndPlaceHolder(title: LocalizableKey.issuedBy.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vDateBy.setTitleAndPlaceHolder(title: LocalizableKey.dayBy.showLanguage, placeHolder: LocalizableKey.select.showLanguage)
        vEmail.setTitleAndPlaceHolder(title: LocalizableKey.partnerEmail.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        lbImage.text = LocalizableKey.partnerImage.showLanguage
        vIDNumber.tfInput.keyboardType = .numberPad
        
        vStep.btnStep2.addTarget(self, action: #selector(btnStep2Tapped), for: .touchUpInside)
        
        let attr1 = LocalizableKey.photoNotice1.showLanguage.toAttributedString(color: AppColor.color_136_136_136, font: AppFont.fontRegular15, isUnderLine: false)
        let attr2 = LocalizableKey.photoNotice2.showLanguage.toAttributedString(color: AppColor.color_136_136_136, font: AppFont.fontBold15, isUnderLine: false)
        let attr3 = LocalizableKey.photoNotice3.showLanguage.toAttributedString(color: AppColor.color_136_136_136, font: AppFont.fontRegular15, isUnderLine: false)
        
        let attr = NSMutableAttributedString()
        
        attr.append(attr1)
        attr.append(attr2)
        attr.append(attr3)
        
        lbPhotoNotice.attributedText = attr
        
        lbFrontPhoto.text = LocalizableKey.frontPhoto.showLanguage
        lbBacksidePhoto.text = LocalizableKey.backsidePhoto.showLanguage
        btnNext.setTitle(LocalizableKey.next.showLanguage, for: .normal)
        btnDeletePhotoFront.isHidden = true
        btnDeletePhotoBacksite.isHidden = true
        
        vGender.listItem = [LocalizableKey.male.showLanguage, LocalizableKey.female.showLanguage, LocalizableKey.other.showLanguage]
    }
    
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    @objc func btnStep2Tapped() {
        if validateInputData() {
            
            if self.vGender.tfInput.text == "Nữ" {
                self.vGender.tfInput.text = "female"
            }
            else if self.vGender.tfInput.text == "Nam" {
                self.vGender.tfInput.text = "male"
            }
            else if self.vGender.tfInput.text == "Khác" {
                self.vGender.tfInput.text = "other"
            }
            
            let param = BossRegisterParam(email: vEmail.getText(),
                                          fullname: vPartnerName.getText(),
                                          gender: self.vGender.tfInput.text,
                                          birthday: vBirthday.tfInput.text,
                                          identity_number: vIDNumber.getText(),
                                          issued_by: vIssuedBy.getText(),
                                          issued_date: vDateBy.tfInput.text,
                                          cmnd_img_before_src: urlPhotoIDFront,
                                          cmnd_img_after_src: urlPhotoIDBackside,
                                          gpkd_img_before_src: nil,
                                          gpkd_img_after_src: nil,
                                          parking_name: nil,
                                          parking_type_id: nil,
                                          number_place: nil,
                                          parking_address: nil,
                                          time_start: nil,
                                          time_end: nil,
                                          code_tax: nil,
                                          price: nil,
                                          package_price: nil,
                                          material: [],
                                          parking_img_src: [],
                                          latAddress: nil,
                                          longAddress: nil)
            print("___====\(param)")
            self.push(controller: SignUpPartnerStep2Router.createModule(param: param))
            
        }
    }
    
    @IBAction func btnPhotoFrontTapped() {
        SelectPhotoCanCropPopUp.shared.showCropPicker(controller: self) { image in
            guard let _image = image else { return }
            self.imgFrontPhoto.image = _image
            self.btnDeletePhotoFront.isHidden = false
            self.presenter?.uploadImageFront(image: _image)
            
        }
    }
    
    @IBAction func btnPhotoBacksideTapped() {
        SelectPhotoCanCropPopUp.shared.showCropPicker(controller: self) { image in
            guard let _image = image else { return }
            self.imgBacksidePhoto.image = _image
            self.btnDeletePhotoBacksite.isHidden = false
            self.presenter?.uploadImageBackside(image: _image)
        }
    }
    
    @IBAction func btnDeleteFrontTapped() {
        imgFrontPhoto.image = AppImage.imgAddImage
        self.btnDeletePhotoFront.isHidden = true
        self.urlPhotoIDFront = ""
    }
    
    @IBAction func btnDeleteBacksideTapped() {
        imgBacksidePhoto.image = AppImage.imgAddImage
        self.btnDeletePhotoBacksite.isHidden = true
        self.urlPhotoIDBackside = ""
    }
    
    @IBAction func btnNextTapped() {
        if validateInputData() {
            
            if self.vGender.tfInput.text == "Nữ" {
                self.vGender.tfInput.text = "female"
            }
            else if self.vGender.tfInput.text == "Nam" {
                self.vGender.tfInput.text = "male"
            }
            else if self.vGender.tfInput.text == "Khác" {
                self.vGender.tfInput.text = "other"
            }
            
            let param = BossRegisterParam(email: vEmail.getText(),
                                          fullname: vPartnerName.getText(),
                                          gender: self.vGender.tfInput.text,
                                          birthday: vBirthday.tfInput.text,
                                          identity_number: vIDNumber.getText(),
                                          issued_by: vIssuedBy.getText(),
                                          issued_date: vDateBy.tfInput.text,
                                          cmnd_img_before_src: urlPhotoIDFront,
                                          cmnd_img_after_src: urlPhotoIDBackside,
                                          gpkd_img_before_src: nil,
                                          gpkd_img_after_src: nil,
                                          parking_name: nil,
                                          parking_type_id: nil,
                                          number_place: nil,
                                          parking_address: nil,
                                          time_start: nil,
                                          time_end: nil,
                                          code_tax: nil,
                                          price: nil,
                                          package_price: nil,
                                          material: [],
                                          parking_img_src: [],
                                          latAddress: nil,
                                          longAddress: nil)
            self.push(controller: SignUpPartnerStep2Router.createModule(param: param))
        }
    }
    
    func didUploadImageFront(photo: PhotoEntity?) {
        self.urlPhotoIDFront = (photo?.imgSrc)&
    }
    
    func didUploadImageBackside(photo: PhotoEntity?) {
        self.urlPhotoIDBackside = (photo?.imgSrc)&
    }
}


extension SignUpPartnerStep1ViewController {
    func validateInputData() -> Bool {
        if self.vPartnerName.getText() == "" && self.vIDNumber.getText() == "" && self.vIssuedBy.getText() == "" && self.vDateBy.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.emptyLoginEmailPassword.showLanguage)
            return false
        }
        
        if self.vPartnerName.getText() == "" {
            hideError(isHidden: false, message: LocalizableKey.errorNamePartner.showLanguage)
            return false
        }
        
        if self.vIDNumber.getText() == "" {
            hideError(isHidden: false, message: LocalizableKey.errorIDNumber.showLanguage)
            return false
        }
        
        if self.vIssuedBy.getText() == "" {
            hideError(isHidden: false, message: LocalizableKey.errorIssueBy.showLanguage)
            return false
        }
        
        if self.vDateBy.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.errorDateBy.showLanguage)
            return false
        }
        
        if self.vEmail.getText() != "" && self.vEmail.tfInput.text?.isValidEmail() == false {
            hideError(isHidden: false, message:  LocalizableKey.invalidLoginEmail.showLanguage)
            return false
        }
        
        if urlPhotoIDFront == ""  {
            hideError(isHidden: false, message:  LocalizableKey.errorPhotoFront.showLanguage)
            return false
        }
        
        if urlPhotoIDBackside == ""  {
            hideError(isHidden: false, message:  LocalizableKey.errorPhotoBackside.showLanguage)
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
