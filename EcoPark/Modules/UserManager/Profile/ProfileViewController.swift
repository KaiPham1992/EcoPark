//
//  ProfileViewController.swift
//  EnglishApp
//
//  Created Tu DV on 10/29/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ProfileViewController: BaseViewController {
    

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbBoss: UILabel!
    @IBOutlet weak var vUsername: AppTextField!
    @IBOutlet weak var vDisplayname: AppTextField!
    @IBOutlet weak var vPhoneNumber: AppTextField!
    @IBOutlet weak var vEmail: AppTextField!
    @IBOutlet weak var vGender: AppDropDown!
    @IBOutlet weak var vBirthDay: AppDateDropDown!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnChangePassword: UIButton!
    @IBOutlet weak var lbError: UILabel!
    @IBOutlet weak var lbVersion: UILabel!
	var presenter: ProfilePresenterProtocol?

    var genderSelect: String = ""
	override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getDataUser()
    }

    private func setupUI() {
        addMenu()
        setTitleNavigation(title: LocalizableKey.MenuProfile.showLanguage)
        imgAvatar.setBorder(borderWidth: 0, borderColor: .clear, cornerRadius: imgAvatar.frame.width / 2)
        vUsername.setTitleAndPlaceHolder(title: LocalizableKey.username.showLanguage, placeHolder: "")
        vDisplayname.setTitleAndPlaceHolder(title: LocalizableKey.displaynameSignUp.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vPhoneNumber.setTitleAndPlaceHolder(title: LocalizableKey.phoneNumberSignUp.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vEmail.setTitleAndPlaceHolder(title: LocalizableKey.emailSignUp.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vGender.backgroundColor = .black
        vBirthDay.backgroundColor = .black
        vGender.setTitleAndPlaceHolder(title: LocalizableKey.gender.showLanguage, placeHolder: LocalizableKey.select.showLanguage)
        vBirthDay.setTitleAndPlaceHolder(title: LocalizableKey.birthday.showLanguage, placeHolder: LocalizableKey.select.showLanguage)
        btnSave.setTitle(LocalizableKey.titleSave.showLanguage, for: .normal)
        btnChangePassword.setTitle(LocalizableKey.titleChangePassword.showLanguage, for: .normal)
        vUsername.tfInput.isUserInteractionEnabled = false
        vDisplayname.tfInput.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        vEmail.tfInput.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        vPhoneNumber.tfInput.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
        btnSave.isEnabled = false
        btnSave.backgroundColor = AppColor.color_205_205_205
        vGender.listItem = [LocalizableKey.male.showLanguage, LocalizableKey.female.showLanguage, LocalizableKey.other.showLanguage]
        vGender.delegateDropDown = self
        vBirthDay.delegateDropDown = self
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

        lbVersion.text = "Version \(appVersion ?? "0")"
    }
    
    
    @objc func textDidChange() {
        btnSave.isEnabled = true
        btnSave.backgroundColor = AppColor.color_0_129_255
    }
    
    private func getDataUser() {
        lbName.text = UserDefaultHelper.shared.loginUserInfo?.fullName
        vUsername.tfInput.text = UserDefaultHelper.shared.loginUserInfo?.displayName
        vDisplayname.tfInput.text = UserDefaultHelper.shared.loginUserInfo?.fullName
        vPhoneNumber.tfInput.text = UserDefaultHelper.shared.loginUserInfo?.phone
        vEmail.tfInput.text = UserDefaultHelper.shared.loginUserInfo?.email
        vBirthDay.tfInput.text = UserDefaultHelper.shared.loginUserInfo?.birthDay?.toString(dateFormat: AppDateFormat.ddMMYYYY)
        imgAvatar.sd_setImage(with:  UserDefaultHelper.shared.loginUserInfo?.urlAvatar, placeholderImage: AppImage.imgPlaceHolder)
        if UserDefaultHelper.shared.loginUserInfo?.gender == "female" {
            vGender.tfInput.text = LocalizableKey.female.showLanguage
        }
        else if UserDefaultHelper.shared.loginUserInfo?.gender == "male" {
            vGender.tfInput.text = LocalizableKey.male.showLanguage
        }
        else if UserDefaultHelper.shared.loginUserInfo?.gender == "other" {
            vGender.tfInput.text = LocalizableKey.other.showLanguage
        }
        
    }
    
    @IBAction func btnSaveTapped() {
        if validateInputData() {
            if self.vGender.tfInput.text == "Nữ" {
                genderSelect = "female"
            }
            else if self.vGender.tfInput.text == "Nam" {
                genderSelect = "male"
            }
            else if self.vGender.tfInput.text == "Khác" {
                genderSelect = "other"
            }
            
            let param = UpdateProfileParam(username: vUsername.getText(), fullname: vDisplayname.getText(), email: vEmail.getText(), phone: vPhoneNumber.getText(), gender: genderSelect, birthDay: vBirthDay.tfInput.text)
            
            self.presenter?.updateProfile(param: param)
        }
    }
    
    @IBAction func btnChangePasswordTapped() {
        self.push(controller: ChangePasswordRouter.createModule(), animated: true)
    }
    
    @IBAction func btnAvatarTapped() {
        SelectPhotoCanCropPopUp.shared.showCropPicker(controller: self) { image in
            guard let _iamge = image else { return }
            self.imgAvatar.image = _iamge
            self.presenter?.updateAvatar(image: _iamge)
        }
    }
}

extension ProfileViewController:  ProfileViewProtocol {
    func didUpdateAvatar() {
        btnSave.isEnabled = true
        btnSave.backgroundColor = AppColor.color_0_129_255
    }
    
    func didUpdateProfile(user: UserEntity) {
        UserDefaultHelper.shared.saveUser(user: user)
        PopUpHelper.shared.showEditProfile {
            self.getDataUser()
        }
    }
}

extension ProfileViewController {
    func validateInputData() -> Bool {
        if self.vDisplayname.tfInput.text == "" && self.vEmail.tfInput.text == "" {//&& self.vPhoneNumber.tfInput.text == "" && self.genderSelect == "" && self.vBirthDay.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.emptyLoginEmailPassword.showLanguage)
            return false
        }

        if self.vDisplayname.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.pleaseEnterDisplayName.showLanguage)
            return false
        }

        if self.vEmail.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.pleaseEnterEmail.showLanguage)
            return false
        }

        if let email = self.vEmail.tfInput.text, email.isValidEmail() == false {
            hideError(isHidden: false, message:  LocalizableKey.invalidLoginEmail.showLanguage)
            return false
        }
        hideError()
        return true
        
    }
    
    func hideError(isHidden: Bool = true, message: String? = nil){
        lbError.isHidden = isHidden
        lbError.text = message
    }
    
}

extension ProfileViewController: AppTextFieldDropDownDelegate {
    func didChangedValue(sender: AppDropDown, item: Any) {
        self.genderSelect = item as! String
        btnSave.isEnabled = true
        btnSave.backgroundColor = AppColor.color_0_129_255
    }
}

extension ProfileViewController: AppDateDropDownDelegate {
    func didChangedValue() {
        btnSave.isEnabled = true
        btnSave.backgroundColor = AppColor.color_0_129_255
    }
}
