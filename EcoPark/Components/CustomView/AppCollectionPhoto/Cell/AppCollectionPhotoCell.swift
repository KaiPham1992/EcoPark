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
    
    var photo: AppPhoto? {
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
    
    func loadImage(photo: AppPhoto?) {
        guard let _photo = photo else { return }
        var urlStr = ""
        if _photo.url&.contains("http"){
             urlStr = "\(_photo.url&)"
        } else {
             urlStr = "\(BASE_URL_IMAGE)\(_photo.url&)"
        }
        
        switch _photo.status {
        case .new:
            imgPhoto.image = AppImage.imgPlaceHolderImage
        case .uploaded:
            if let image = _photo.image {
                imgPhoto.image = image
            } else if let url = URL(string: urlStr) {
                imgPhoto.sd_setImage(with: url, placeholderImage: AppImage.imgPlaceHolderImage)
            } else {
                 imgPhoto.image = AppImage.imgPlaceHolderImage
            }
            
        case .error:
            imgPhoto.image = AppImage.imgPlaceHolderImage
        }
    }
}
