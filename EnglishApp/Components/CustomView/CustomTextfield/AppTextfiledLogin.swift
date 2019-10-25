//
//  AppTextfiledLogin.swift
//  RedStar
//
//  Created by Coby on 11/17/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import Foundation
import UIKit

class AppTextfiledLogin: UIView {
    
    lazy var tfInput: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    lazy var image: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "avatarDefautl")
        img.contentMode = UIView.ContentMode.scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        layout()
    }
    
    private func setupView() {
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.backgroundColor = .white
        self.layer.borderColor = AppColor.gray999999.cgColor
        self.layer.borderWidth = 1
        
        tfInput.backgroundColor = .clear
        tfInput.borderStyle = .none
        //-- add line
        
        //font style
        tfInput.textColor = .black
        tfInput.placeHolderColor = UIColor.white.withAlphaComponent(0.5)
        addSubview(image)
        addSubview(tfInput)
    }
    
    func layout() {

        //---
//        image.anchor( right: self.leftAnchor, rightConstant: 10, widthConstant: 21, heightConstant: 21)
//        image.centerYToSuperview(constant: 0)
        image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 11).isActive = true
        image.heightAnchor.constraint(equalToConstant: 15).isActive = true
        image.widthAnchor.constraint(equalToConstant: 15).isActive = true
        image.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        tfInput.anchor( left: image.rightAnchor, right: self.rightAnchor, leftConstant: 10, rightConstant: 0)
        tfInput.centerYToView(view: image)
    }
    
    func setPlaceHolder(placeholder: String) {
        tfInput.attributedPlaceholder = placeholder.showLanguage.toAttributedString(color: AppColor.gray999999, font: tfInput.font, isUnderLine: false)
    }
    
    func setImage(img: UIImage?) {
        image.image = img
    }
}
