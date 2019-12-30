//
//  SignUpPartnerStep3ViewController.swift
//  EnglishApp
//
//  Created Tu DV on 10/31/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SignUpPartnerStep3ViewController: BaseViewController, SignUpPartnerStep3ViewProtocol {
    
    
    @IBOutlet weak var vStep: PartnerStepView!
    @IBOutlet weak var lbUtility: UILabel!
    @IBOutlet weak var lbImage: UILabel!
    @IBOutlet weak var lbSubImage: UILabel!
    @IBOutlet weak var vUtility: UtilityView!
    @IBOutlet weak var vPhoto: AppCollectionPhoto!
    @IBOutlet weak var heightPhoto: NSLayoutConstraint!
    @IBOutlet weak var lbTermAndPolicy: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var lbError: UILabel!
    
    var isSelect: Bool = true
    var presenter: SignUpPartnerStep3PresenterProtocol?
        
    var listMaterial: [String] = []
    var listImageParking: [AppPhoto] = []
    var url_listImage: [String] = []
    
    var param: BossRegisterParam? 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter?.getListMaterial()
    }
    
    private func setupUI() {
        setTitleNavigation(title: LocalizableKey.MenuSignUpPartner.showLanguage)
        addBackToNavigation()
        vStep.setStep3()
        lbUtility.text = LocalizableKey.utilityOther.showLanguage.uppercased()
        lbImage.text = LocalizableKey.parkingImage.showLanguage.uppercased()
        lbSubImage.text = LocalizableKey.parkingSubImage.showLanguage
        
        vPhoto.configCollectionImageView(delegate: self, controller: self, isSingleSelected: false)
        btnDone.setTitle(LocalizableKey.DoneSignUp.showLanguage, for: .normal)
        
        setTextTermAndPolicy()
        
        
        vStep.btnStep1.addTarget(self, action: #selector(btnStep1Tapped), for: .touchUpInside)
        vStep.btnStep2.addTarget(self, action: #selector(btnStep2Tapped), for: .touchUpInside)
    }
    
    @objc func btnStep1Tapped() {
    }
    
    @objc func btnStep2Tapped() {
        self.pop()
    }
    
    
    private func setTextTermAndPolicy() {
        let attr1 = LocalizableKey.termAndPolicySignUp1.showLanguage.toAttributedString(color: AppColor.color_136_136_136, font: AppFont.fontRegular15, isUnderLine: false)
        
        let attr2 = LocalizableKey.DoneSignUp.showLanguage.uppercased().toAttributedString(color: AppColor.color_136_136_136, font: AppFont.fontBold15, isUnderLine: false)
        
        let attr3 = LocalizableKey.termAndPolicySignUp2.showLanguage.toAttributedString(color: AppColor.color_136_136_136, font: AppFont.fontRegular15, isUnderLine: false)
        
        let attr4 = LocalizableKey.termAndPolicySignUp3.showLanguage.toAttributedString(color: AppColor.color_136_136_136, font: AppFont.fontRegular15, isUnderLine: false)
        
        let attr5 = LocalizableKey.termAndPolicySignUp4.showLanguage.toAttributedString(color: AppColor.color_82_240_249, font: AppFont.fontBold15, isUnderLine: true)
        
        let attr6 = LocalizableKey.termAndPolicyText3.showLanguage.toAttributedString(color: AppColor.color_136_136_136, font: AppFont.fontRegular15, isUnderLine: false)
        
        let attr7 = LocalizableKey.termAndPolicySignUp5.showLanguage.toAttributedString(color: AppColor.color_82_240_249, font: AppFont.fontBold15, isUnderLine: true)
        
        let attr8 = LocalizableKey.termAndPolicySignUp6.showLanguage.toAttributedString(color: AppColor.color_136_136_136, font: AppFont.fontRegular15, isUnderLine: false)
        
        let attr = NSMutableAttributedString()
        attr.append(attr1)
        attr.append(attr2)
        attr.append(attr3)
        attr.append(attr4)
        attr.append(attr5)
        attr.append(attr6)
        attr.append(attr7)
        attr.append(attr8)
        lbTermAndPolicy.attributedText = attr
        
        self.lbTermAndPolicy.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnlabel(_ :)))
        tapGesture.numberOfTapsRequired = 1
        self.lbTermAndPolicy.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapOnlabel(_ gesture: UITapGestureRecognizer) {
        guard let text = lbTermAndPolicy.text else { return }
        let termOfUse = (text as NSString).range(of: LocalizableKey.termAndPolicySignUp4.showLanguage)
        let policy = (text as NSString).range(of: LocalizableKey.termAndPolicySignUp5.showLanguage)
        if gesture.didTapAttributedTextInLabel(label: lbTermAndPolicy, inRange: termOfUse) {
            let webView = WebViewController.createModule(isTermCondition: true)
            webView.isSignUp = true
            self.push(controller: webView)
        } else if gesture.didTapAttributedTextInLabel(label: lbTermAndPolicy, inRange: policy) {
            let webView = WebViewController.createModule(isTermCondition: false)
            webView.isSignUp = true
            self.push(controller: webView)
        }
    }
    
    @IBAction func btnDoneTapped() {
        let listMaterialActive = vUtility.utilyties.filter({$0.is_active == "1"})
        listMaterial = listMaterialActive.map({$0.id&})
        if validateInputData() {
            url_listImage = vPhoto.listImage.map({ $0.url& })
            
            let paramInput = BossRegisterParam(email: param?.email,
                                               fullname: param?.fullname,
                                               gender: param?.gender,
                                               birthday: param?.birthday,
                                               identity_number: param?.identity_number,
                                               issued_by: param?.issued_by,
                                               issued_date: param?.issued_date,
                                               cmnd_img_before_src: param?.cmnd_img_before_src,
                                               cmnd_img_after_src: param?.cmnd_img_after_src,
                                               gpkd_img_before_src: param?.gpkd_img_before_src,
                                               gpkd_img_after_src:param?.gpkd_img_after_src,
                                               parking_name: param?.parking_name,
                                               parking_type_id: param?.parking_type_id,
                                               number_place: param?.number_place,
                                               parking_address: param?.parking_address,
                                               time_start: param?.time_start,
                                               time_end: param?.time_end,
                                               code_tax: param?.code_tax,
                                               price: param?.price,
                                               package_price: param?.package_price,
                                               material: listMaterial,
                                               parking_img_src: url_listImage,
                                               latAddress: param?.latAddress,
                                               longAddress: param?.longAddress)
            presenter?.bossRegister(param: paramInput)
        }
    }
    
    func hideError(isHidden: Bool = true, message: String? = nil){
        lbError.isHidden = isHidden
        lbError.text = message ?? ""
    }
    
    func validateInputData() -> Bool {
        if listImageParking.count <= 1 {
            hideError(isHidden: false, message:  LocalizableKey.errorMinimunPhoto.showLanguage)
            return false
        }
        
        if listMaterial == [] {
            hideError(isHidden: false, message:  LocalizableKey.errorUtility.showLanguage)
            return false
        }
        hideError()
        return true
    }
    
    
    func didBossRegister(parkingInfo: ParkingInfoEntity?) {
        presenter?.getProfileUser()
        parkingInfo?.id = UserDefaultHelper.shared.parkingID
        self.push(controller: SignUpPartnerWaitingRouter.createModule())
        
    }
    
    func didUploadImage(photo: PhotoEntity?) {
        url_listImage.append((photo?.imgSrc)&)
        self.btnDone.isEnabled = true
        self.btnDone.backgroundColor = AppColor.color_0_129_255
    }
    
    func didGetListMaterial(listMaterial: [MaterialEntity]) {
        vUtility.utilyties = listMaterial
        let listMaterialActive = vUtility.utilyties.filter({$0.is_active == "1"})
        self.listMaterial = listMaterialActive.map({$0.id&})
    }
    func didGetProfileUser(user: UserEntity) {
        UserDefaultHelper.shared.saveUser(user: user)
    }
}

extension SignUpPartnerStep3ViewController: AppCollectionPhotoDelegate {
    func removeImage(_ collectionView: AppCollectionPhoto, index: Int) {
        print(index)
    }
    
    func appCollectionPhoto(_ collectionView: AppCollectionPhoto, changedHeight height: CGFloat) {
        self.heightPhoto.constant = height
    }
    
    func appCollectionPhoto(_ collectionView: AppCollectionPhoto, selectedImages images: [AppPhoto]) {
        if self.listImageParking.count == 0 {
            self.listImageParking = images
        } else {
            self.listImageParking.append(contentsOf: images)
        }
        
    }
}
