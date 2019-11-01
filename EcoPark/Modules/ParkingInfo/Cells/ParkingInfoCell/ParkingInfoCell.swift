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
    @IBOutlet weak var cvUtility: UICollectionView!
    
    var listUtility: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        listUtility = ["ic_roof_on", "ic_carwash_off", "ic_repair_on", "ic_rent_on", "ic_supermarket_off", "ic_atm_on", "ic_hotel_off", "ic_coffee_on"]
        setupUI()
        configCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        vParkingName.setTitleAndPlaceHolder(title: LocalizableKey.parkingName.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vParkingType.setTitleAndPlaceHolder(title: LocalizableKey.parkingType.showLanguage, placeHolder: LocalizableKey.select.showLanguage)
        vParkingAddress.setTitleAndPlaceHolder(title: LocalizableKey.parkingAddress.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vParkingAddress.setPlaceHolder(placeHolder: LocalizableKey.enter.showLanguage)
        vOpen.setTitleAndPlaceHolder(title: LocalizableKey.parkingOpen.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vClose.setTitleAndPlaceHolder(title: LocalizableKey.parkingClose.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
    }
}

extension ParkingInfoCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
