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
        
        if UserDefaultHelper.shared.loginUserInfo == nil {
            return [
                MenuItem(imgIcon: AppImage.imgFindAround, title: LocalizableKey.MenuFindAround.showLanguage),        MenuItem(imgIcon: AppImage.imgPrivacy, title: LocalizableKey.MenuPolicy.showLanguage),
                MenuItem(imgIcon: AppImage.imgSecurity, title: LocalizableKey.MenuSecuriry.showLanguage),
                MenuItem(imgIcon: AppImage.imgCall, title: LocalizableKey.MenuHotLine.showLanguage),
                MenuItem(imgIcon: AppImage.imgLanguage, title: LocalizableKey.MenuLanguage.showLanguage)
            ]
        } else if UserDefaultHelper.shared.loginUserInfo?.userIsBoss == true {
            return [
                MenuItem(imgIcon: AppImage.imgHistoryParking, title: LocalizableKey.MenuHistoryParking.showLanguage),
                MenuItem(imgIcon: AppImage.imgMyParking, title: LocalizableKey.MenuMyInfo.showLanguage),
                MenuItem(imgIcon: AppImage.imgFindAround, title: LocalizableKey.MenuFindAround.showLanguage),
                MenuItem(imgIcon: AppImage.imgHistory, title: LocalizableKey.MenuHistory.showLanguage),
                MenuItem(imgIcon: AppImage.imgNotification, title: LocalizableKey.MenuNotification.showLanguage),
                MenuItem(imgIcon: AppImage.imgWallet, title: LocalizableKey.MenuWallet.showLanguage),
                MenuItem(imgIcon: AppImage.imgProfile, title: LocalizableKey.MenuProfile.showLanguage),
                MenuItem(imgIcon: AppImage.imgPrivacy, title: LocalizableKey.MenuPolicy.showLanguage),
                MenuItem(imgIcon: AppImage.imgSecurity, title: LocalizableKey.MenuSecuriry.showLanguage),
                MenuItem(imgIcon: AppImage.imgCall, title: LocalizableKey.MenuHotLine.showLanguage),
                MenuItem(imgIcon: AppImage.imgLanguage, title: LocalizableKey.MenuLanguage.showLanguage)
            ]
        } else {
            return [
                MenuItem(imgIcon: AppImage.imgFindAround, title: LocalizableKey.MenuFindAround.showLanguage),
                MenuItem(imgIcon: AppImage.imgHistory, title: LocalizableKey.MenuHistory.showLanguage),
                MenuItem(imgIcon: AppImage.imgNotification, title: LocalizableKey.MenuNotification.showLanguage),
                MenuItem(imgIcon: AppImage.imgWallet, title: LocalizableKey.MenuWallet.showLanguage),
                MenuItem(imgIcon: AppImage.imgProfile, title: LocalizableKey.MenuProfile.showLanguage),
                MenuItem(imgIcon: AppImage.imgPrivacy, title: LocalizableKey.MenuPolicy.showLanguage),
                MenuItem(imgIcon: AppImage.imgSecurity, title: LocalizableKey.MenuSecuriry.showLanguage),
                MenuItem(imgIcon: AppImage.imgCall, title: LocalizableKey.MenuHotLine.showLanguage),
                MenuItem(imgIcon: AppImage.imgLanguage, title: LocalizableKey.MenuLanguage.showLanguage)
            ]
        }
        
        // Not login
    }
}

class MenuCell: BaseTableCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var lbLanguage: UILabel!
    @IBOutlet weak var vNotification: UIView!
    
    @IBOutlet weak var btnLanguage: UIButton!
//    @IBOutlet weak var vNotification: UIView!
    var totalUnread: Int = 0
    
    
    var menuItem: MenuItem? {
        didSet {
            guard let menuItem = menuItem else { return }
            lbTitle.text = menuItem.title
            imgIcon.image = menuItem.imgIcon
            guard let isSelected = menuItem.isSelected else { return }
            lbLanguage.text = LocalizableKey.MenuVNEN.showLanguage
            
            if isSelected {
                lbTitle.textColor = AppColor.color_0_129_255
                imgIcon.tintColor = AppColor.color_0_129_255
            } else {
                lbTitle.textColor = AppColor.color_102_102_102
                imgIcon.tintColor = AppColor.color_102_102_102
            }
            
            lbLanguage.isHidden = menuItem.imgIcon != AppImage.imgLanguage
            btnLanguage.isHidden = menuItem.imgIcon != AppImage.imgLanguage
            
            vNotification.isHidden = true
            
            if totalUnread > 0 &&  menuItem.imgIcon == AppImage.imgNotification {
                 vNotification.isHidden = false
            }
            
        }
    }
    
    func btnLanguagueTapped() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
