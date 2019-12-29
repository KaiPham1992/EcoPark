//
//  UtilityViewCell.swift
//  EnglishApp
//
//  Created by Ngoc Duong on 10/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

enum UtilityModelType: String {
    case roof
    case carwash
    case repair
    case rent
    case superMarket
    case atm
    case hotel
    case coffee
}
class UtilityModel {
    var type: UtilityModelType = UtilityModelType.roof
    var iconOn: UIImage?
    var iconOff: UIImage?
    
    var isSelected: Bool = true
    
    init(type: UtilityModelType, iconOn: UIImage?, iconOff: UIImage?, isSelected: Bool = true) {
        self.type = type
        self.iconOn = iconOn
        self.iconOff = iconOff
        self.isSelected = isSelected
    }
    
    static func toArray() -> [UtilityModel] {
        var array = [UtilityModel]()
        array.append(UtilityModel(type: .roof, iconOn: AppImage.imgRootOn, iconOff: AppImage.imgRootOff))
        array.append(UtilityModel(type: .carwash, iconOn: AppImage.imgCarwashOn, iconOff: AppImage.imgCarwashOff))
        array.append(UtilityModel(type: .repair, iconOn: AppImage.imgRepairOn, iconOff: AppImage.imgRepairOff))
        array.append(UtilityModel(type: .rent, iconOn: AppImage.imgRentOn, iconOff: AppImage.imgRentOff))
        
        array.append(UtilityModel(type: .superMarket, iconOn: AppImage.imgSupermarketOn, iconOff: AppImage.imgSupermarketOff))
        array.append(UtilityModel(type: .atm, iconOn: AppImage.imgAtmOn, iconOff: AppImage.imgAtmOff))
        array.append(UtilityModel(type: .hotel, iconOn: AppImage.imgHotelOn, iconOff: AppImage.imgHotelOff))
        array.append(UtilityModel(type: .coffee, iconOn: AppImage.imgCoffeeOn, iconOff: AppImage.imgCoffeeOff))
        
        return array
    }
    
    static func setMaterial(listMaterilType: [UtilityModelType]) -> [UtilityModel] {
        var array = [UtilityModel]()
        
        if listMaterilType.contains(.roof) {
            array.append(UtilityModel(type: .roof, iconOn: AppImage.imgRootOn, iconOff: AppImage.imgRootOff, isSelected: true))
        } else {
            array.append(UtilityModel(type: .roof, iconOn: AppImage.imgRootOn, iconOff: AppImage.imgRootOff, isSelected: false))
        }
        
        if listMaterilType.contains(.carwash) {
            array.append(UtilityModel(type: .carwash, iconOn: AppImage.imgCarwashOn, iconOff: AppImage.imgCarwashOff, isSelected: true))
        } else {
            array.append(UtilityModel(type: .carwash, iconOn: AppImage.imgCarwashOn, iconOff: AppImage.imgCarwashOff, isSelected: false))
        }
        
        if listMaterilType.contains(.repair) {
            array.append(UtilityModel(type: .repair, iconOn: AppImage.imgRepairOn, iconOff: AppImage.imgRepairOff, isSelected: true))
        } else {
            array.append(UtilityModel(type: .repair, iconOn: AppImage.imgRepairOn, iconOff: AppImage.imgRepairOff, isSelected: false))
        }
        
        if listMaterilType.contains(.rent) {
            array.append(UtilityModel(type: .rent, iconOn: AppImage.imgRentOn, iconOff: AppImage.imgRentOff, isSelected: true))
        } else {
            array.append(UtilityModel(type: .rent, iconOn: AppImage.imgRentOn, iconOff: AppImage.imgRentOff, isSelected: false))
        }
        
        if listMaterilType.contains(.superMarket) {
            array.append(UtilityModel(type: .superMarket, iconOn: AppImage.imgSupermarketOn, iconOff: AppImage.imgSupermarketOff, isSelected: true))
        } else {
            array.append(UtilityModel(type: .superMarket, iconOn: AppImage.imgSupermarketOn, iconOff: AppImage.imgSupermarketOff, isSelected: false))
        }
        
        if listMaterilType.contains(.atm) {
            array.append(UtilityModel(type: .atm, iconOn: AppImage.imgAtmOn, iconOff: AppImage.imgAtmOff, isSelected: true))
        } else {
            array.append(UtilityModel(type: .atm, iconOn: AppImage.imgAtmOn, iconOff: AppImage.imgAtmOff, isSelected: false))
        }
        
        if listMaterilType.contains(.hotel) {
            array.append(UtilityModel(type: .hotel, iconOn: AppImage.imgHotelOn, iconOff: AppImage.imgHotelOff, isSelected: true))
        } else {
            array.append(UtilityModel(type: .hotel, iconOn: AppImage.imgHotelOn, iconOff: AppImage.imgHotelOff, isSelected: false))
        }
        
        if listMaterilType.contains(.coffee) {
            array.append(UtilityModel(type: .coffee, iconOn: AppImage.imgCoffeeOn, iconOff: AppImage.imgCoffeeOff, isSelected: true))
        } else {
            array.append(UtilityModel(type: .coffee, iconOn: AppImage.imgCoffeeOn, iconOff: AppImage.imgCoffeeOff, isSelected: false))
        }
        
        return array
    }
}

class UtilityViewCell: UICollectionViewCell {
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    
    var utility: MaterialEntity? {
        didSet {
            guard let utility = utility else { return }
            lbName.text = utility.name& == "" ? utility.plain_name&: utility.name
            imgIcon.sd_setImage(with: utility.urlOn) { (image, _, _, _) in
                self.imgIcon.image = image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                if  utility.is_active == "0" {
                    
                    self.imgIcon.tintColor = AppColor.color_0_129_255
                } else {
                    
                    self.imgIcon.tintColor = AppColor.color158_158_158
                }
            }
            
            //----
            if  utility.is_active == "1" {
                self.setBorder(borderWidth: 1, borderColor: AppColor.color_0_129_255, cornerRadius: 10)
                imgIcon.tintColor = AppColor.color_0_129_255
                self.lbName.textColor = AppColor.color_0_129_255
            } else {
                self.setBorder(borderWidth: 1, borderColor: AppColor.color158_158_158, cornerRadius: 10)
                self.lbName.textColor = AppColor.color158_158_158
                imgIcon.tintColor = AppColor.color158_158_158
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
