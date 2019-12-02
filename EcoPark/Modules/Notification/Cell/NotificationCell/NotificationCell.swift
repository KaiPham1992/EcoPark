//
//  NotificationCell.swift
//  EcoPark
//
//  Created by Henry on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

enum NotificationType {
    case MyNotification
    case SystemNotification
}

enum NotificationStatus {
    case UnRead
    case IsRead
}

class NotificationCell: BaseTableCell {
    
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbDateTime: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
    }
    
    func displayData(type: NotificationType, status: NotificationStatus, datetime: String, content: String) {
        
        setUpStatusIU(status: status)
        setUpTypeUI(type: type)
        
        lbDateTime.text = datetime
        lbContent.text = content.htmlToString
    }
    
    private func setUpTypeUI(type: NotificationType) {
        if type == NotificationType.MyNotification {
            lbType.text = LocalizableKey.MenuNotification.showLanguage
        } else {
            lbType.text = LocalizableKey.System.showLanguage
        }
    }
    
    private func setUpStatusIU(status: NotificationStatus) {
        if status == NotificationStatus.UnRead {
            imgIcon.image = AppImage.imgNotificationOn
            lbType.textColor = AppColor.color_0_129_255
            lbDateTime.textColor = AppColor.color40_50_75
            lbContent.textColor = AppColor.black
            background.backgroundColor = AppColor.color_228_237_249
        } else {
            imgIcon.image = AppImage.imgNotificationOff
            lbType.textColor = AppColor.color_102_102_102
            lbDateTime.textColor = AppColor.color_102_102_102
            lbContent.textColor = AppColor.color_102_102_102
            background.backgroundColor = AppColor.white
        }
    }
}
