//
//  ParkingInfoCell.swift
//  EcoPark_Dev
//
//  Created by Tu DV on 11/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class ParkingInfoCell: UITableViewCell {

    @IBOutlet weak var vParkingName: AppTextField!
    @IBOutlet weak var vParkingType: AppDropDown!
    @IBOutlet weak var vParkingAddress: AppTextView!
    @IBOutlet weak var vOpen: AppTextField!
    @IBOutlet weak var vClose: AppTextField!
    @IBOutlet weak var cvUtility: UtilityView!
    
    var parkingInfo: ParkingInfoEntity?
    var listUtility: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        listUtility = ["ic_roof_on", "ic_carwash_off", "ic_repair_on", "ic_rent_on", "ic_supermarket_off", "ic_atm_on", "ic_hotel_off", "ic_coffee_on"]
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        vParkingName.setTitleAndPlaceHolder(title: LocalizableKey.parkingName.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vParkingType.setTitleAndPlaceHolder(title: LocalizableKey.parkingType.showLanguage, placeHolder: LocalizableKey.select.showLanguage)
        vParkingAddress.setTitleAndPlaceHolder(title: LocalizableKey.parkingAddress.showLanguage, placeHolder: "")
        vParkingAddress.setPlaceHolder(placeHolder: LocalizableKey.enter.showLanguage)
        vOpen.setTitleAndPlaceHolder(title: LocalizableKey.parkingOpen.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vClose.setTitleAndPlaceHolder(title: LocalizableKey.parkingClose.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
    }
    
    func setData(parkingInfo: ParkingInfoEntity?) {
        vParkingName.tfInput.text = parkingInfo?.name
        vParkingType.tfInput.text = parkingInfo?.parking_type
        vParkingAddress.tvInput.text = parkingInfo?.address
        vOpen.tfInput.text = parkingInfo?.time_start?.toString(dateFormat: .HHmm)
        vClose.tfInput.text = parkingInfo?.time_end?.toString(dateFormat: .HHmm)
        
        cvUtility.setMaterial(listMaterial: [.roof, .carwash, .rent, .atm])
        
    }
}


