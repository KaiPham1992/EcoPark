//
//  LoginViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/9/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
//import CryptoSwift
//import GoogleSignIn
//import FBSDKLoginKit
//import FBSDKCoreKit
import SystemConfiguration

enum LoginType {
    case gmail
    case facebook
    case normal
}

class LoginViewController: BaseViewController {
    
    var presenter: LoginPresenterProtocol?
    
    @objc func backView(_ sender: Any) {
        self.dismiss()
    }
    
    @IBOutlet weak var vUserName: AppTextfiledLogin!
    @IBOutlet weak var vPassword: AppTextfiledLogin!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lbForgot: UILabel!
    @IBOutlet weak var lbRegister: UILabel!
    @IBOutlet weak var lbLanguage: UILabel!
    @IBOutlet weak var btnEnglish: UIButton!
    @IBOutlet weak var btnVietnamese: UIButton!
    @IBOutlet weak var lbError: UILabel!
    
    var callBackLoginSuccessed : (()->())?
    var loginType = LoginType.normal
    var paramLogin: Any?
    var passwordText: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        vPassword.tfInput.delegate = self
//        GIDSignIn.sharedInstance().delegate = self
//        GIDSignIn.sharedInstance().presentingViewController = self
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        self.addButtonToNavigation(image: AppImage.imgClear, style: .left, action: #selector(backView))
    }
    
    override func setTitleUI() {

        vUserName.setPlaceHolder(placeholder: LocalizableKey.username.showLanguage)
        vUserName.setImage(img: UIImage(named: "ic_person"))
        vPassword.setPlaceHolder(placeholder: LocalizableKey.LoginPassword.showLanguage)
        vPassword.setImage(img:  AppImage.iconPadlock)
        vUserName.backgroundColor = AppColor.color_32_45_55
        vPassword.backgroundColor = AppColor.color_32_45_55
        vPassword.tfInput.delegate = self
        vPassword.tfInput.isSecureTextEntry = true
        lbLanguage.text = LocalizableKey.language.showLanguage
        btnLogin.setTitle(LocalizableKey.MenuLogin.showLanguage, for: .normal)
        btnEnglish.setTitle(LocalizableKey.english.showLanguage, for: .normal)
        btnVietnamese.setTitle(LocalizableKey.vietnamese.showLanguage, for: .normal)
        lbForgot.text = LocalizableKey.ForgotPass.showLanguage
        lbRegister.text = LocalizableKey.NotYetAccount.showLanguage + ", " + LocalizableKey.Register.showLanguage
        if LanguageHelper.currentAppleLanguage() == "en" {
            btnEnglish.backgroundColor = AppColor.color_0_129_255
            btnVietnamese.backgroundColor = AppColor.gray999999
        } else {
            btnEnglish.backgroundColor = AppColor.gray999999
            btnVietnamese.backgroundColor = AppColor.color_0_129_255
        }
    }
    
    @IBAction func btnLoginTapped() {
        dismissKeyBoard()
        if validateInputData() {
            presenter?.login(username: vUserName.tfInput.text&, password: passwordText.sha256())
        }
        
    }
    
    @IBAction func btnForgotPassTapped() {
        self.push(controller: ForgotPasswordRouter.createModule())
    }
    
    @IBAction func btnRegisterTapped() {
        self.push(controller: SignUpRouter.createModule())
    }
    
    @IBAction func btnEnglishTapped() {
        btnEnglish.backgroundColor = AppColor.color_0_129_255
        btnVietnamese.backgroundColor = AppColor.gray999999
        LanguageHelper.setAppleLAnguageTo(lang: LanguageType.english)
        AppRouter.shared.openHomeView()
    }
    
    @IBAction func btnVietnameseTapped() {
        btnEnglish.backgroundColor = AppColor.gray999999
        btnVietnamese.backgroundColor = AppColor.color_0_129_255
        LanguageHelper.setAppleLAnguageTo(lang: LanguageType.vietname)
        AppRouter.shared.openHomeView()
    }
}

extension LoginViewController {
    func validateInputData() -> Bool {
        
        if self.vUserName.tfInput.text == "" && self.vPassword.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.emptyLoginEmailPassword.showLanguage)
            return false
        }
        
        if self.vUserName.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.pleaseEnterEmail.showLanguage)
            return false
        }
        
//        if let email = self.vUserName.tfInput.text, email.isValidEmail() == false {
//            hideError(isHidden: false, message:  LocalizableKey.invalidLoginEmail.showLanguage)
//            return false
//        }
        if self.vPassword.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.pleaseEnterPassword.showLanguage)
            return false
        }
        
        
        if let password = self.vPassword.tfInput.text, password.count < 6 {
            hideError(isHidden: false, message:  LocalizableKey.invalidLoginPassword.showLanguage)
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


extension LoginViewController: LoginViewProtocol {
    func didLogin(user: UserEntity?) {
        
        self.callBackLoginSuccessed?()
        self.dismiss()
//        AppRouter.shared.openHome()
        guard let _user = user else { return }
        UserDefaultHelper.shared.saveUser(user: _user)
        if user?.infoParking != nil {
            AppRouter.shared.test()
        }
    }
    
    func didError(error: APIError?) {
        guard let message = error?.message else { return }
        UserDefaultHelper.shared.clearUser()
        hideError(isHidden: false, message:  LocalizableKey.INVALID_USERNAME_OR_PASSWORD.showLanguage)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == vPassword.tfInput {
            var hashPassword = String()
            let newChar = string.first
            let offsetToUpdate = passwordText.index(passwordText.startIndex, offsetBy: range.location)
            
            if string == "" {
                passwordText.remove(at: offsetToUpdate)
                return true
            }
            else { passwordText.insert(newChar!, at: offsetToUpdate) }
            
            for _ in 0 ..< passwordText.count {  hashPassword += "*" }
            textField.text = hashPassword
            if textField.text&.count > 0 {
//                vPassword.textFieldDidChanged(vPassword.tfInput)
            }
            print(self.passwordText)
            return false
        }
        return true
    }
    
}
