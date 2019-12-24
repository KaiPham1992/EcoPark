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

    var user: UserEntity? {
        didSet {
            getDataUser()
        }
    }
    
    var genderSelect: String = ""
	override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        getDataUser()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getProfile()
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
        lbName.text = user?.fullName
        vUsername.tfInput.text = user?.displayName
        vDisplayname.tfInput.text = user?.fullName
        vPhoneNumber.tfInput.text = user?.phone
        vEmail.tfInput.text = user?.email
        vBirthDay.tfInput.text = user?.birthDay?.toString(dateFormat: AppDateFormat.ddMMYYYYTransaction)
        imgAvatar.sd_setImage(with:  user?.urlAvatar, placeholderImage: AppImage.imgPlaceHolder)
        if user?.gender == "female" {
            vGender.tfInput.text = LocalizableKey.female.showLanguage
        }
        else if user?.gender == "male" {
            vGender.tfInput.text = LocalizableKey.male.showLanguage
        }
        else if user?.gender == "other" {
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
    func didGetProfile(user: UserEntity) {
        self.user = user
    }
    
    func didUpdateAvatar() {
        btnSave.isEnabled = true
        btnSave.backgroundColor = AppColor.color_0_129_255
    }
    
    func didUpdateProfile(user: UserEntity) {
        UserDefaultHelper.shared.saveUser(user: user)
        
        self.user = user
        PopUpHelper.shared.showEditProfile {
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
