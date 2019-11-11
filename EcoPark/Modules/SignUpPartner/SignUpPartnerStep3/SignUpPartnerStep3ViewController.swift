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
    
	var presenter: SignUpPartnerStep3PresenterProtocol?

    var listUtility: [String] = []
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        listUtility = ["ic_roof_on", "ic_carwash_off", "ic_repair_on", "ic_rent_on", "ic_supermarket_off", "ic_atm_on", "ic_hotel_off", "ic_coffee_on"]
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
        self.push(controller: SignUpPartnerWaitingRouter.createModule())
    }
}

extension SignUpPartnerStep3ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        cell.imgItem.image = UIImage(named: listUtility[indexPath.item])
        return cell
    }
    
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
    func appCollectionPhoto(_ collectionView: AppCollectionPhoto, changedHeight height: CGFloat) {
        self.heightPhoto.constant = height
    }
    
    func appCollectionPhoto(_ collectionView: AppCollectionPhoto, selectedImages images: [AppPhoto]) {
        
    }
    
    
}
