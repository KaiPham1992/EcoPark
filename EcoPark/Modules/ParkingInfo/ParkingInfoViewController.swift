//
//  ParkingInfoViewController.swift
//  EnglishApp
//
//  Created Tu DV on 10/31/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import GooglePlaces

class ParkingInfoViewController: BaseViewController {
    
    @IBOutlet weak var tbParkingInfo: UITableView!
    @IBOutlet weak var lbActive: UILabel!
    @IBOutlet weak var vActive: CustomSwitch!
    @IBOutlet weak var lbError: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    
    var presenter: ParkingInfoPresenterProtocol?
    
    var isExplandParkingInfo = true
    var isExplandLicenseInfo = true
    
    var addressSelect: String = ""
    var latSelect: Double = 0
    var longSelect: Double = 0
    var isSelectAddress: Bool = false
    
    var parkingName: String = ""
    var parkingTypeID: String = ""
    var openTime: String = ""
    var closeTime: String = ""
    var parkingAddress: String = ""
    var lat: Double = 0
    var long: Double = 0
    var listMaterial: [String] = []
    var codeTax: String = ""
    
    var listParkingType: [ParkingTypeEntity] = [] {
        didSet {
            tbParkingInfo.reloadData()
        }
    }
    var parkingInfo: ParkingInfoEntity? {
        didSet {
            tbParkingInfo.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleNavigation(title: LocalizableKey.MenuMyInfo.showLanguage)
        btnSave.setTitle(LocalizableKey.titleSave.showLanguage, for: .normal)
        lbActive.text = LocalizableKey.switchStatusParking.showLanguage
        btnSave.isEnabled = false
        btnSave.backgroundColor = AppColor.color_205_205_205
        addMenu()
        configTableView()
        vActive.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    
    func getData() {
        var parkingID = UserDefaultHelper.shared.loginUserInfo?.infoParking?.id
        if parkingID == "" || parkingID == nil {
            parkingID = UserDefaultHelper.shared.loginUserInfo?.parkingID
        }
        presenter?.getParkingInfo(id: parkingID&)
        presenter?.getListParkingType()
    }
    
    @IBAction func swActive() {
        var parkingID = UserDefaultHelper.shared.loginUserInfo?.infoParking?.id
        if parkingID == "" || parkingID == nil {
            parkingID = UserDefaultHelper.shared.loginUserInfo?.parkingID
        }
        if vActive.isOn {
            presenter?.changeStatusParking(parkingID: parkingID&, isActive: "1")
        } else {
            presenter?.changeStatusParking(parkingID: parkingID&, isActive: "0")
        }
    }
    
    @IBAction func btnSaveTapped() {
        var parkingID = UserDefaultHelper.shared.loginUserInfo?.infoParking?.id
        if parkingID == "" || parkingID == nil {
            parkingID = UserDefaultHelper.shared.loginUserInfo?.parkingID
        }
        if validateInputData() {
            presenter?.updateInfoParking(param: UpdateInfoParkingParam(parking_id: parkingID&,
                                                                       parking_address: parkingAddress,
                                                                       gpkd_img_before_src: parkingInfo?.gpkd_img_before_src,
                                                                       gpkd_img_after_src: parkingInfo?.gpkd_img_after_src,
                                                                       parking_name: parkingName,
                                                                       parking_type_id: parkingTypeID,
                                                                       number_place: parkingInfo?.number_place,
                                                                       time_start: openTime,
                                                                       time_end: closeTime,
                                                                       code_tax: codeTax,
                                                                       price: parkingInfo?.price,
                                                                       package_price: parkingInfo?.package_price,
                                                                       package_number: parkingInfo?.package_number,
                                                                       material: listMaterial,
                                                                       lat: self.lat,
                                                                       long: self.long))
        }
    }
    
    @objc func imageParkingTapped() {
        btnSave.isEnabled = true
        btnSave.backgroundColor = AppColor.color_0_129_255
        guard let  listImage = parkingInfo?.img else { return }
        let listImageStr = listImage.map({ $0.img_src!})
        
        self.push(controller: ImageParkingRouter.createModule(listImage: listImageStr))
    }
    
    func hideError(isHidden: Bool = true, message: String? = nil){
        lbError.isHidden = isHidden
        lbError.text = message ?? ""
    }
    
    func validateInputData() -> Bool {
        if parkingName == "" {
            hideError(isHidden: false, message: LocalizableKey.errorParkingName.showLanguage)
            return false
        }
        if parkingTypeID == "" {
            hideError(isHidden: false, message: LocalizableKey.errorParkingType.showLanguage)
            return false
        }
        if parkingAddress == "" {
            hideError(isHidden: false, message: LocalizableKey.errorParkingAddress.showLanguage)
            return false
        }
        if openTime == "" {
            hideError(isHidden: false, message: LocalizableKey.errorOpenTime.showLanguage)
            return false
        }
        if closeTime == "" {
            hideError(isHidden: false, message: LocalizableKey.errorCloseTime.showLanguage)
            return false
        }
        if listMaterial == [] {
            hideError(isHidden: false, message: LocalizableKey.errorUtility.showLanguage)
            return false
        }
        
//        if codeTax == "" {
//            hideError(isHidden: false, message: LocalizableKey.errorParkingType.showLanguage)
//            return false
//        }
        
        hideError()
        return true
    }
}

extension ParkingInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func configTableView() {
        tbParkingInfo.dataSource = self
        tbParkingInfo.delegate = self
        
        tbParkingInfo.registerXibFile(OtherInfoCell.self)
        tbParkingInfo.registerXibFile(SlideImageCell.self)
        tbParkingInfo.registerXibFile(ParkingInfoCell.self)
        tbParkingInfo.registerXibFile(LicenseInfoCell.self)
        
        tbParkingInfo.estimatedRowHeight = 200
        tbParkingInfo.rowHeight = UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            if isExplandParkingInfo == true {
                return 2
            } else {
                return 0
            }
            
        default:
            if isExplandLicenseInfo == true {
                return 1
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let otherInfoCell = tableView.dequeueTableCell(OtherInfoCell.self)
            otherInfoCell.setData(parkingInfo: parkingInfo)
            return otherInfoCell
        case 1:
            if indexPath.row == 0 {
                let slideImageCell = tableView.dequeueTableCell(SlideImageCell.self)
                slideImageCell.setData(parkingInfo: parkingInfo)
                slideImageCell.btnCamera.addTarget(self, action: #selector(imageParkingTapped), for: .touchUpInside)
                return slideImageCell
            } else {
                let parkingInfoCell = tableView.dequeueTableCell(ParkingInfoCell.self)
                parkingInfoCell.setData(parkingInfo: parkingInfo, listItem: self.listParkingType, isSelectAddress: isSelectAddress)
                parkingInfoCell.selectAddress = self.addressSelect
                parkingInfoCell.delegate = self
                return parkingInfoCell
            }
        default:
            let licenseInfoCell = tableView.dequeueTableCell(LicenseInfoCell.self)
            licenseInfoCell.setData(parkingInfo: parkingInfo)
            licenseInfoCell.delegate = self
            return licenseInfoCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 125
        case 1:
            if indexPath.row == 0 {
                return 215
            } else {
                return UITableView.automaticDimension
            }
        default:
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return nil
        case 1:
            let headerView = HeaderInfoView()
            headerView.setupUI(title: LocalizableKey.parkingInfo.showLanguage.uppercased())
            headerView.delegate = self
            headerView.section = section
            headerView.setExpland(expland: isExplandParkingInfo)
            return headerView
            
        default:
            let headerView = HeaderInfoView()
            headerView.setupUI(title: LocalizableKey.juridicalInfomation.showLanguage.uppercased())
            headerView.delegate = self
            headerView.section = section
            headerView.setExpland(expland: isExplandLicenseInfo)
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 50
        }
    }
}

extension ParkingInfoViewController: HeaderViewDelegate {
    func toggleSection(header: HeaderInfoView, section: Int) {
        if section == 1 {
            let expland = !isExplandParkingInfo
            isExplandParkingInfo = expland
            header.setExpland(expland: expland)
            let sectionExpland = IndexSet(integer: section)
            tbParkingInfo.reloadSections(sectionExpland, with: UITableView.RowAnimation.automatic)
        } else {
            let expland = !isExplandLicenseInfo
            isExplandLicenseInfo = expland
            header.setExpland(expland: expland)
            let sectionExpland = IndexSet(integer: section)
            tbParkingInfo.reloadSections(sectionExpland, with: .automatic)
        }
    }
    
}



extension ParkingInfoViewController: ParkingInfoViewProtocol {
    func didGetParkingInfo(parkingInfo: ParkingInfoEntity?) {
        self.parkingInfo = parkingInfo
        guard let _parkingInfo = parkingInfo else { return }
        self.parkingName = _parkingInfo.name&
        self.parkingTypeID = _parkingInfo.type_id&
        self.openTime = _parkingInfo.time_start?.toString(dateFormat: .HHmm) ?? ""
        self.closeTime = _parkingInfo.time_end?.toString(dateFormat: .HHmm) ?? ""
        self.parkingAddress = _parkingInfo.address&
        self.lat = _parkingInfo.lat ?? 0
        self.long = _parkingInfo.long ?? 0
//        self.listMaterial = _parkingInfo.material?.map({ $0.id ?? ""}) ?? [""]
        self.codeTax = _parkingInfo.code_tax&
        if parkingInfo?.is_active == "1" {
            vActive.isOn = true
        } else {
            vActive.isOn = false
        }
    }
    
    func didGetListParkingType(listParkingType: [ParkingTypeEntity]) {
        self.listParkingType = listParkingType
    }
    
    func didUpdateInfoParking(parkingInfo: ParkingInfoEntity?) {
        guard let parkingID = UserDefaultHelper.shared.loginUserInfo?.infoParking?.id else { return  }
        PopUpHelper.shared.showMessage(message: LocalizableKey.updateSuccess.showLanguage, width: popUpwidth) {}
        presenter?.getParkingInfo(id: parkingID)
        tbParkingInfo.reloadData()
    }
}

extension ParkingInfoViewController: LicenseInfoCellDelegate {
    func getDataLicenseInfo(codeTax: String) {
        self.codeTax = codeTax
        btnSave.isEnabled = true
        btnSave.backgroundColor = AppColor.color_0_129_255
    }
}

extension ParkingInfoViewController: ParkingInfoCellDelegate {
    
    func getParkingInfo(parkingName: String, parkingTypeID: String, parkingAddress: String, openTime: String, closeTime: String, material: [String]) {
        
        self.parkingName = parkingName
        self.parkingTypeID = parkingTypeID
        if isSelectAddress {
            self.parkingAddress = addressSelect
            self.lat = latSelect
            self.long = longSelect
        } else {
            self.parkingAddress = parkingAddress
        }
        self.openTime = openTime
        self.closeTime = closeTime
        self.listMaterial = material
        
        btnSave.isEnabled = true
        btnSave.backgroundColor = AppColor.color_0_129_255
    }
    
    func selectAddress() {
        btnSave.isEnabled = true
        btnSave.backgroundColor = AppColor.color_0_129_255
        let vcHomeFind = HomeFindRouter.createModule(address: "")
        vcHomeFind.delegate = self
        vcHomeFind.isSelectAddressSignUp = true
        self.push(controller: vcHomeFind)
    }
    
    
}

extension ParkingInfoViewController: HomeFindViewControllerDelegate {
    func didSelectMyLocation() {
        
    }
    
    func didSelectAddressSignUp(address: String, lat: CLLocationDegrees, long: CLLocationDegrees) {
        self.addressSelect = address
        self.latSelect = lat
        self.longSelect = long
        self.isSelectAddress = true
        tbParkingInfo.reloadData()
    }
    
    func didSelectAddress(address: String, lat: CLLocationDegrees, long: CLLocationDegrees) {
    }
}

extension ParkingInfoViewController: CustomSwitchDelegate {
    func turnOnMatching() {
        btnSave.isEnabled = true
        btnSave.backgroundColor = AppColor.color_0_129_255
    }
    
    func showPopupConfirm() {
    }
}
