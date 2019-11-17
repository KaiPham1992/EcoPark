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
    @IBOutlet weak var cvUtility: UICollectionView!
    @IBOutlet weak var vPhoto: AppCollectionPhoto!
    @IBOutlet weak var heightPhoto: NSLayoutConstraint!
    @IBOutlet weak var lbTermAndPolicy: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var lbError: UILabel!
    
    var isSelect: Bool = true
    var presenter: SignUpPartnerStep3PresenterProtocol?
    
    var listUtility: [String] = []
    
    var listMaterial: [String] = []
    var listImageParking: [AppPhoto] = []
    var url_listImage: [String] = [] 
    
    var param: BossRegisterParam? 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listUtility = ["ic_roof_on", "ic_carwash_on", "ic_repair_on", "ic_rent_on", "ic_supermarket_on", "ic_atm_on", "ic_hotel_on", "ic_coffee_on"]
        listMaterial = ["1","2","3","4","5","6","7","8"]
        setupUI()
        configCollectionView()
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
    }
    
    private func setTextTermAndPolicy() {
        let attr1 = LocalizableKey.termAndPolicySignUp1.showLanguage.toAttributedString(color: AppColor.color_136_136_136, font: AppFont.fontRegular15, isUnderLine: false)
        
        let attr2 = LocalizableKey.DoneSignUp.showLanguage.uppercased().toAttributedString(color: AppColor.color_136_136_136, font: AppFont.fontRegular15, isUnderLine: true)
        
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
    }
    
    @IBAction func btnDoneTapped() {
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
                                               parking_img_src: url_listImage)
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
        hideError()
        return true
    }
    
    
    func didBossRegister(parkingInfo: ParkingInfoEntity?) {
        self.push(controller: SignUpPartnerWaitingRouter.createModule())
        
    }
    
    func didUploadImage(photo: PhotoEntity?) {
        url_listImage.append((photo?.imgSrc)&)
    }
}

extension SignUpPartnerStep3ViewController: UICollectionViewDataSource {
    
    func configCollectionView() {
        cvUtility.registerXibCell(UtilityCell.self)
        
        cvUtility.dataSource = self
        cvUtility.delegate = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listUtility.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(UtilityCell.self, indexPath: indexPath)
        //        cell.imgItem.image = UIImage(named: listUtility[indexPath.item])
        cell.setUI(isSelect: self.isSelect, index: indexPath.item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            isSelect = !isSelect
            cvUtility.reloadItems(at: [indexPath])
            if isSelect {
                listMaterial.append("1")
            } else {
                listMaterial.remove(at: indexPath.item)
            }
        case 1:
            isSelect = !isSelect
            cvUtility.reloadItems(at: [indexPath])
            if isSelect {
                listMaterial.append("2")
            } else {
                listMaterial.remove(at: indexPath.item)
            }
        case 2:
            isSelect = !isSelect
            cvUtility.reloadItems(at: [indexPath])
            if isSelect {
                listMaterial.append("3")
            } else {
                listMaterial.remove(at: indexPath.item)
            }
        case 3:
            isSelect = !isSelect
            cvUtility.reloadItems(at: [indexPath])
            if isSelect {
                listMaterial.append("4")
            } else {
                listMaterial.remove(at: indexPath.item)
            }
        case 4:
            isSelect = !isSelect
            cvUtility.reloadItems(at: [indexPath])
            if isSelect {
                listMaterial.append("5")
            } else {
                listMaterial.remove(at: indexPath.item)
            }
        case 5:
            isSelect = !isSelect
            cvUtility.reloadItems(at: [indexPath])
            if isSelect {
                listMaterial.append("6")
            } else {
                listMaterial.remove(at: indexPath.item)
            }
        case 6:
            isSelect = !isSelect
            cvUtility.reloadItems(at: [indexPath])
            if isSelect {
                listMaterial.append("7")
            } else {
                listMaterial.remove(at: indexPath.item)
            }
        case 7:
            isSelect = !isSelect
            cvUtility.reloadItems(at: [indexPath])
            if isSelect {
                listMaterial.append("8")
            } else {
                listMaterial.remove(at: indexPath.item)
            }
        default:
            isSelect = !isSelect
            cvUtility.reloadItems(at: [indexPath])
        }
    }
}

extension SignUpPartnerStep3ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 90, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
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
        self.listImageParking = images
    }
}
