//
//  ParkingInfoCell.swift
//  EcoPark_Dev
//
//  Created by Tu DV on 11/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

protocol ParkingInfoCellDelegate: class {
    func getParkingInfo(parkingName: String, parkingTypeID: String, parkingAddress: String, openTime: String, closeTime: String, material: [String])
    
    func selectAddress()
}

class ParkingInfoCell: UITableViewCell {
    
    @IBOutlet weak var vParkingName: AppTextField!
    @IBOutlet weak var vParkingType: AppDropDown!
    @IBOutlet weak var vParkingAddress: AppTextView!
    @IBOutlet weak var vOpen: AppTextField!
    @IBOutlet weak var vClose: AppTextField!
    @IBOutlet weak var cvUtility: UtilityView!
    
    weak var delegate: ParkingInfoCellDelegate?
    
    var isSelectAddress: Bool = false
    var selectAddress: String = ""
    var parkingInfo: ParkingInfoEntity?
    var parkingTypeID: String = ""
    var listMaterial: [String] = []
    var listParkingType: [ParkingTypeEntity] = []
    
    let datePickerTimeOpen = UIDatePicker()
    let formatterTimeOpen = DateFormatter()
    let datePickerTimeClose = UIDatePicker()
    let formatterTimeClose = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        vOpen.setTitleAndPlaceHolder(title: LocalizableKey.parkingOpen.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vClose.setTitleAndPlaceHolder(title: LocalizableKey.parkingClose.showLanguage, placeHolder: LocalizableKey.enter.showLanguage)
        vParkingType.delegateDropDown = self
        cvUtility.delegate = self
        setTime()
        
        vParkingName.tfInput.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        
    }
    
    func setData(parkingInfo: ParkingInfoEntity?, listItem: [ParkingTypeEntity], isSelectAddress: Bool) {
        vParkingName.tfInput.text = parkingInfo?.name
        vParkingType.tfInput.text = parkingInfo?.parking_type
        if isSelectAddress {
            vParkingAddress.tvInput.text = selectAddress
        } else {
            vParkingAddress.tvInput.text = parkingInfo?.address
        }
        vOpen.tfInput.text = parkingInfo?.time_start?.toString(dateFormat: .HHmm)
        vClose.tfInput.text = parkingInfo?.time_end?.toString(dateFormat: .HHmm)
        self.listParkingType = listItem
        if LanguageHelper.currentAppleLanguage() == "en" {
            vParkingType.listItem = listItem.map({$0.key&})
        } else {
            vParkingType.listItem = listItem.map({$0.name&})
        }
        parkingTypeID = parkingInfo?.type_id ?? ""
//        cvUtility.utilyties = parkingInfo?.material ?? []
    if let material = parkingInfo?.material {
               cvUtility.utilyties = material.sorted{$0.id& < $1.id&}
               } else {
                   cvUtility.utilyties = []
               }
               
           
    }
    
    @objc func textFieldDidChanged() {
        let listMaterialActive = cvUtility.utilyties.filter({$0.is_active == "1"})
        listMaterial = listMaterialActive.map({$0.id&})
        
        delegate?.getParkingInfo(parkingName: vParkingName.getText(), parkingTypeID: parkingTypeID, parkingAddress: vParkingAddress.tvInput.text, openTime: vOpen.getText(), closeTime: vClose.getText(), material: listMaterial)
    }
    
    @IBAction func btnSelectAddressTapped() {
        delegate?.selectAddress()
    }
    
    private func setTime() {
        //--Time
        datePickerTimeOpen.datePickerMode = .time
        datePickerTimeClose.datePickerMode = .time
        let toolbarTimeOpen = UIToolbar()
        toolbarTimeOpen.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelDatePicker))
        let cancelButtonClose = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelDatePicker))
        toolbarTimeOpen.setItems([doneButton,spaceButton,cancelButton], animated: false)
        vOpen.tfInput.inputAccessoryView = toolbarTimeOpen
        vOpen.tfInput.inputView = datePickerTimeOpen
        
        //close time
        let toolbarTimeClose = UIToolbar()
        toolbarTimeClose.sizeToFit()
        
        let doneButtonClose = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneDatePickerClose))
        toolbarTimeClose.setItems([doneButtonClose,spaceButton,cancelButtonClose], animated: false)
        
        vClose.tfInput.inputAccessoryView = toolbarTimeClose
        vClose.tfInput.inputView = datePickerTimeClose
    }
    
    @objc func doneDatePicker(){
        //For time formate
        formatterTimeOpen.dateFormat = AppDateFormat.HHmm.formatString
        vOpen.tfInput.text = formatterTimeOpen.string(from: datePickerTimeOpen.date)
        let listMaterialActive = cvUtility.utilyties.filter({$0.is_active == "1"})
        listMaterial = listMaterialActive.map({$0.id&})
        delegate?.getParkingInfo(parkingName: vParkingName.getText(), parkingTypeID: parkingTypeID, parkingAddress: vParkingAddress.tvInput.text, openTime: vOpen.getText(), closeTime: vClose.getText(), material: listMaterial)
        //dismiss date picker dialog
        self.contentView.endEditing(true)
    }
    
    @objc func doneDatePickerClose(){
        //For time formate
        formatterTimeClose.dateFormat = AppDateFormat.HHmm.formatString
        vClose.tfInput.text = formatterTimeClose.string(from: datePickerTimeClose.date)
        let listMaterialActive = cvUtility.utilyties.filter({$0.is_active == "1"})
        listMaterial = listMaterialActive.map({$0.id&})
        
        delegate?.getParkingInfo(parkingName: vParkingName.getText(), parkingTypeID: parkingTypeID, parkingAddress: vParkingAddress.tvInput.text, openTime: vOpen.getText(), closeTime: vClose.getText(), material: listMaterial)
        //dismiss date picker dialog
        self.contentView.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        //cancel button dismiss datepicker dialog
        self.contentView.endEditing(true)
    }
}

extension ParkingInfoCell: AppTextFieldDropDownDelegate {
    func didChangedValue(sender: AppDropDown, item: Any, index: Int) {
        
        parkingTypeID = listParkingType[index]._id ?? ""
        delegate?.getParkingInfo(parkingName: vParkingName.getText(), parkingTypeID: parkingTypeID, parkingAddress: vParkingAddress.tvInput.text, openTime: vOpen.getText(), closeTime: vClose.getText(), material: listMaterial)
    }
    
}

extension ParkingInfoCell: UtilityViewDelegate {
    func didSelect() {
        let listMaterialActive = cvUtility.utilyties.filter({$0.is_active == "1"})
        listMaterial = listMaterialActive.map({$0.id&})
        delegate?.getParkingInfo(parkingName: vParkingName.getText(), parkingTypeID: parkingTypeID, parkingAddress: vParkingAddress.tvInput.text, openTime: vOpen.getText(), closeTime: vClose.getText(), material: listMaterial)
    }
}

