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


class ParkingInfoViewController: UIViewController, ParkingInfoViewProtocol {

    @IBOutlet weak var tbParkingInfo: UITableView!
    
	var presenter: ParkingInfoPresenterProtocol?

    var isExplandParkingInfo = true
    var isExplandLicenseInfo = true
    
	override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
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
            return otherInfoCell
        case 1:
            if indexPath.row == 0 {
                let slideImageCell = tableView.dequeueTableCell(SlideImageCell.self)
                return slideImageCell
            } else {
                let parkingInfoCell = tableView.dequeueTableCell(ParkingInfoCell.self)
                return parkingInfoCell
            }
        default:
            let licenseInfoCell = tableView.dequeueTableCell(LicenseInfoCell.self)
            
            return licenseInfoCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
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
            return headerView
            
        default:
            let headerView = HeaderInfoView()
            headerView.setupUI(title: LocalizableKey.parkingInfo.showLanguage.uppercased())
            headerView.delegate = self
            headerView.section = section
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
