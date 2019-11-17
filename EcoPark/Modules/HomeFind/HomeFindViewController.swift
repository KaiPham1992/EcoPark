//
//  HomeFindViewController.swift
//  EnglishApp
//
//  Created Ngoc Duong on 10/26/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import GooglePlaces

protocol HomeFindViewControllerDelegate: class {
    func didSelectAddress(address: String, lat: CLLocationDegrees, long: CLLocationDegrees)
    func didSelectAddressSignUp(address: String, lat: CLLocationDegrees, long: CLLocationDegrees)
    func didSelectMyLocation()
}

class HomeFindViewController: BaseViewController, HomeFindViewProtocol {
    
    var presenter: HomeFindPresenterProtocol?
    
    @IBOutlet weak var vSearch: AppSeachBarRight!
    @IBOutlet weak var tbFind: UITableView!
    
    weak var delegate: HomeFindViewControllerDelegate?
    var isSelectAddressSignUp: Bool = false
    var locations = [GoogleLocationEntity]() {
        didSet {
            tbFind.reloadData()
        }
    }
    var address: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setTitleUI() {
        super.setTitleUI()
        if isSelectAddressSignUp {
            vSearch.setTitleAndPlaceHolder(placeHolder: "Chọn vị trí")
        } else {
            vSearch.setTitleAndPlaceHolder(placeHolder: "Chọn điểm đến")
        }
        
    }
    
    override func setUpViews() {
        super.setUpViews()
        vSearch.actionSearch = { text in
            self.presenter?.searchPlaceByString(text: text)
        }
        configureTable()
        
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        if isSelectAddressSignUp {
            addButtonTextToNavigation(title: "CHỌN VỊ TRÍ", style: .left, action: nil, textColor: AppColor.color_0_129_255, font: AppFont.fontBold18)
        } else {
            addButtonTextToNavigation(title: "CHỌN ĐIỂM ĐẾN", style: .left, action: nil, textColor: AppColor.color_0_129_255, font: AppFont.fontBold18)
        }
        
        
        addButtonTextToNavigation(title: "Huỷ tìm kiếm", style: .right, action: #selector(btnCancel), textColor: AppColor.color_0_129_255, font: AppFont.fontRegular15)
    }
    
    
    @objc func btnCancel() {
        self.pop()
    }
    
    func didSearch(locations: [GoogleLocationEntity]) {
        self.locations = locations
    }
    
    func getPlaceDetail(placeId: String) {
        self.presenter?.getPlaceDetail(placeId: placeId)
    }
    
    func didGetPlaceDetail(lat: Double, long: Double) {
        if isSelectAddressSignUp {
            self.delegate?.didSelectAddressSignUp(address: self.address, lat: lat, long: long)
        } else {
            self.delegate?.didSelectAddress(address: self.address, lat: lat, long: long)
        }
        self.pop()
    }
    
}

extension HomeFindViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count + 1
    }
    
    func configureTable() {
        tbFind.registerXibFile(HomeFindCell.self)
        tbFind.registerXibFile(FindAroundMeCell.self)
        
        tbFind.dataSource = self
        tbFind.delegate = self
        tbFind.separatorStyle = .none
        tbFind.estimatedRowHeight = 80
        tbFind.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let cell = tableView.dequeue(FindAroundMeCell.self, for: indexPath)
            
            return cell
        }
        
        let cell = tableView.dequeue(HomeFindCell.self, for: indexPath)
        cell.location = locations[indexPath.row - 1]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row != 0 {
            if isSelectAddressSignUp {
                let item = locations[indexPath.row - 1]
                self.address = item.getAddress()
                getPlaceDetail(placeId: item.placeID)
            } else {
                let item = locations[indexPath.row - 1]
                self.address = item.getPlaceAddress()
                getPlaceDetail(placeId: item.placeID)
            }
            
            if indexPath.row == 0 {
                delegate?.didSelectMyLocation()
                self.pop()
            } else {
                let item = locations[indexPath.row - 1]
                self.address = item.getPlaceAddress()
                getPlaceDetail(placeId: item.placeID)
            }
        }
    }
}
