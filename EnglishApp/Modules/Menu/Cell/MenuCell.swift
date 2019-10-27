//
//  MenuCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/11/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class MenuItem {
    var imgIcon: UIImage?
    var title: String?
    var isSelected: Bool?
    
    init(imgIcon: UIImage, title: String) {
        self.imgIcon = imgIcon
        self.title = title
        self.isSelected = false
    }
    
    class func toArray() -> [MenuItem] {
        
//        if UserDefaultHelper.shared.loginUserInfo?.email == emailDefault {
//            return [
//                MenuItem(imgIcon: AppImage.ic_historyparking_on, title: LocalizableKey.MenuInfo.showLanguage),
//                MenuItem(imgIcon: AppImage.imgTop, title: LocalizableKey.MenuTop.showLanguage),
//                MenuItem(imgIcon: AppImage.imgQA, title: LocalizableKey.MenuQA.showLanguage),
//                MenuItem(imgIcon: AppImage.imgLanguage, title: LocalizableKey.MenuLanguage.showLanguage),
//                MenuItem(imgIcon: AppImage.imgSaved, title: LocalizableKey.MenuSaved.showLanguage),
//                MenuItem(imgIcon: AppImage.imgHistoryCheck, title: LocalizableKey.MenuHistory.showLanguage),
//                MenuItem(imgIcon: AppImage.imgPrivacy, title: LocalizableKey.MenuPrivacy.showLanguage),
//            ]
//        }
//
//        if UserDefaultHelper.shared.loginUserInfo?.socialType == nil || UserDefaultHelper.shared.loginUserInfo?.socialType == "normal" {
//            return [
//                MenuItem(imgIcon: AppImage.imgInfo, title: LocalizableKey.MenuInfo.showLanguage),
//                MenuItem(imgIcon: AppImage.imgTop, title: LocalizableKey.MenuTop.showLanguage),
//                MenuItem(imgIcon: AppImage.imgQA, title: LocalizableKey.MenuQA.showLanguage),
//                MenuItem(imgIcon: AppImage.imgLanguage, title: LocalizableKey.MenuLanguage.showLanguage),
//                MenuItem(imgIcon: AppImage.imgSaved, title: LocalizableKey.MenuSaved.showLanguage),
//                MenuItem(imgIcon: AppImage.imgHistoryCheck, title: LocalizableKey.MenuHistory.showLanguage),
//                MenuItem(imgIcon: AppImage.imgPrivacy, title: LocalizableKey.MenuPrivacy.showLanguage),
//                MenuItem(imgIcon: AppImage.imgChangePass, title: LocalizableKey.MenuChangePassword.showLanguage),
//                MenuItem(imgIcon: AppImage.imgLogout, title: LocalizableKey.MenuLogout.showLanguage)
//            ]
//        }
        
        return [
            MenuItem(imgIcon: AppImage.imgHistoryParking, title: LocalizableKey.MenuHistoryParking.showLanguage),
            MenuItem(imgIcon: AppImage.imgMyParking, title: LocalizableKey.MenuMyInfo.showLanguage),
            MenuItem(imgIcon: AppImage.imgFindAround, title: LocalizableKey.MenuFindAround.showLanguage),
            MenuItem(imgIcon: AppImage.imgHistory, title: LocalizableKey.MenuHistory.showLanguage),
            MenuItem(imgIcon: AppImage.imgNotification, title: LocalizableKey.MenuNotification.showLanguage),
            MenuItem(imgIcon: AppImage.imgNotification, title: LocalizableKey.MenuWallet.showLanguage),
            MenuItem(imgIcon: AppImage.imgProfile, title: LocalizableKey.MenuProfile.showLanguage),
            MenuItem(imgIcon: AppImage.imgPrivacy, title: LocalizableKey.MenuPolicy.showLanguage),
            MenuItem(imgIcon: AppImage.imgSecurity, title: LocalizableKey.MenuSecuriry.showLanguage),
            MenuItem(imgIcon: AppImage.imgCall, title: LocalizableKey.MenuHotLine.showLanguage),
            MenuItem(imgIcon: AppImage.imgLanguage, title: LocalizableKey.MenuLanguage.showLanguage)
        ]
        
    }
}

class MenuCell: BaseTableCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    
    var menuItem: MenuItem? {
        didSet {
            guard let menuItem = menuItem else { return }
            lbTitle.text = menuItem.title
            imgIcon.image = menuItem.imgIcon
            guard let isSelected = menuItem.isSelected else { return }
            
            
            if isSelected {
                lbTitle.textColor = AppColor.color_0_129_255
                imgIcon.tintColor = AppColor.color_0_129_255
            } else {
                lbTitle.textColor = AppColor.color_102_102_102
                imgIcon.tintColor = AppColor.color_102_102_102
            }
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
