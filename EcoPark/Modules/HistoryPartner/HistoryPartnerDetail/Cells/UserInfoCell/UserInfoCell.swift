//
//  UserInfoCell.swift
//  EcoPark
//
//  Created by Tu DV on 11/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {

    @IBOutlet weak var lbUserInfo: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var lbCarType: UILabel!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbCarNumber: UILabel!
    @IBOutlet weak var lbNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbUserInfo.text = LocalizableKey.userInfo.showLanguage
        lbCarType.text = LocalizableKey.vehicleType.showLanguage
        lbCarNumber.text = LocalizableKey.licensePlate.showLanguage
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(historyParkingDetail: HistoryBookingParkingResponse?) {
        guard let _historyParkingDetail = historyParkingDetail else { return }
        lbUserName.text = _historyParkingDetail.fullname
        lbType.text = _historyParkingDetail.vehicle_name
        lbNumber.text = _historyParkingDetail.license_plates
        imgAvatar.sd_setImage(with: _historyParkingDetail.urlAvatar, placeholderImage: AppImage.iconUsername)
    }
}
