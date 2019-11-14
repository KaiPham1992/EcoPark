//
//  AppCollectionPhotoCell.swift
//  Oganban
//
//  Created by Kai Pham on 12/22/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Foundation

//AppCollectionPhotoCell


import UIKit
import SDWebImage

class AppCollectionPhotoCell: BaseCollectionCell {
    let imgPhoto: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.backgroundColor = .clear
        img.setBorder(borderWidth: 0, borderColor: .white, cornerRadius: 10)
        return img
    }()
    
    let imgClose: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = AppImage.imgDelete_1
        
        return img
    }()
    
    let btnRemove : UIButton = {
        let btn = UIButton()
        
        return btn
    }()
    
    var photo: UIImage? {
        didSet {
            loadImage(photo: photo)
        }
    }
    
    
    override func setupViews() {
        super.setupViews()
        self.contentView.backgroundColor = .clear
        //--
        addSubview(imgPhoto)
        addSubview(imgClose)
        addSubview(btnRemove)
        
        //--
        imgPhoto.fillSuperview()
        imgClose.anchor(topAnchor, right: rightAnchor, topConstant: 5, rightConstant: 5, widthConstant: 20, heightConstant: 20)
        btnRemove.fillToView(view: imgClose)
        
        self.setBorder(borderWidth: 0, borderColor: .clear, cornerRadius: 0)
    }
    
    func loadImage(photo: UIImage?) {
        imgPhoto.image = photo
    }
}
