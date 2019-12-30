//
//  ParkingUserDetailViewController.swift
//  EnglishApp
//
//  Created Ngoc Duong on 10/30/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import MapKit

class ParkingUserDetailViewController: BaseViewController, ParkingUserDetailViewProtocol {
    
    @IBOutlet weak var vAppImageSlide: AppImageSlide!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var ratingBar: AppRatingView!
    @IBOutlet weak var lbTitleTime: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbTitleType: UILabel!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbTitleEmptyPlace: UILabel!
    @IBOutlet weak var lbEmptyPlace: UILabel!
    @IBOutlet weak var lbTitlePriceOneHour: UILabel!
    @IBOutlet weak var lbPriceOneHour: UILabel!
    @IBOutlet weak var lbTitlePriceEightHour: UILabel!
    @IBOutlet weak var lbPriceEightHour: UILabel!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var btnContact: UIButton!
    @IBOutlet weak var btnDirect: UIButton!
    @IBOutlet weak var cltMaterial: UtilityView!
    @IBOutlet weak var btnBookNow: UIButton!
    
    var presenter: ParkingUserDetailPresenterProtocol?
    var parking: ParkingEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getParkingDetail()
    }
    
    override func setUpViews() {
        super.setUpViews()
        
        ratingBar.isUserInteractionEnabled = false
        lbTitleTime.text = LocalizableKey.parkingTime.showLanguage
        lbTitleType.text = LocalizableKey.titleType.showLanguage
        lbTitleEmptyPlace.text = LocalizableKey.titlePlace.showLanguage
        lbTitlePriceOneHour.text = LocalizableKey.titlePriceOne.showLanguage
        lbTitlePriceEightHour.text = LocalizableKey.titlePriceEight.showLanguage
        
        btnContact.setTitle(LocalizableKey.titleContactMe.showLanguage, for: .normal)
        btnDirect.setTitle(LocalizableKey.titleDirection.showLanguage, for: .normal)
        cltMaterial.isUserInteractionEnabled = false
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.titleParkDetail.showLanguage)
    }
    
    @IBAction func btnBookingTapped() {
        let vc = BookingInfoRouter.createModule(parking: self.parking)
        self.push(controller: vc)
    }
    
    @IBAction func btnContactTapped() {
        // Code here
        //        if let url = URL(string: "tel://1900587") {
        //            UIApplication.shared.open(url)
        //        }
        
        guard let phone = parking?.phone else { return}
        Utils.callPhone(phoneNumber: phone)
    }
    
    @IBAction func btnDirectTapped() {
        guard let lat = parking?.lat, let long = parking?.long else { return }
        openGoogleMapForPlace(lat: lat, long: long)
    }
    
    func displayData(info: ParkingInfoEntity) {
        if let listImage = info.img?.map({ $0.imageURL }){
            vAppImageSlide.listItem = listImage as [Any]
        }
        lbName.text = info.name&
        
        if let rating = info.rating {
            ratingBar.setStar(number: rating)
        }
        if let totalRating = info.total_rating {
            ratingBar.setTitle(number: totalRating)
        } else {
            ratingBar.hideTitle()
        }
        
        if let timeStart = info.time_start?.toString(dateFormat: .HHmm),
            let timeEnd = info.time_end?.toString(dateFormat: .HHmm) {
            lbTime.text = timeStart + " - " + timeEnd
        }
        lbType.text = info.parking_type
        
        let totalPlace = info.number_place ?? 0
        if let parkedPlace = info.parkedNumber {
            let emptyPlace = totalPlace - parkedPlace
            lbEmptyPlace.text = "\(emptyPlace)/\(totalPlace) " + LocalizableKey.place.showLanguage.lowercased()
        } else {
            lbEmptyPlace.text = "\(totalPlace)/\(totalPlace) " + LocalizableKey.place.showLanguage.lowercased()
        }
        
        if let price = info.price {
            lbPriceOneHour.text = price.toCurrency
        }
        if let packagePrice = info.package_price {
            lbPriceEightHour.text = packagePrice.toCurrency
        }
        
        lbAddress.text = info.address
        //        cltMaterial.setMaterial(listMaterial: [.roof, .repair, .rent, .atm])
        //        cltMaterial.setMaterial(listMaterialEntity: info.material ?? [])
        if let material = info.material {
            cltMaterial.utilyties = material.sorted{$0.id& < $1.id&}
        } else {
            cltMaterial.utilyties = []
        }
        
        
        
        cltMaterial.utilyties = info.material ?? []
    }
    
    // MARK: Get error
    func didGetError(error: APIError) {
        printError(message: error.message)
    }
    
    // MARK: Get Park Info
    func getParkingDetail() {
        if let id = parking?.parking_id {
            self.presenter?.getParkingInfo(id: id)
        }
    }
    func didGetInfo(info: ParkingInfoEntity) {
        displayData(info: info)
    }
}

// MARK: Direct to location
extension ParkingUserDetailViewController {
    
    func openAppleMapForPlace(lat: Double, long: Double) {
        let latitude: CLLocationDegrees =  lat
        let longitude: CLLocationDegrees =  long
        
        let regionDistance: CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.parking?.parking_name
        mapItem.openInMaps(launchOptions: options)
        
    }
    
    func openGoogleMapForPlace(lat: Double, long: Double) {
        let lat = lat
        let long = long
        
        let customURL = "comgooglemaps://"
        let urlRoute = "comgooglemaps://?saddr=&daddr=\(lat),\(long)&directionsmode=driving"
        if UIApplication.shared.canOpenURL(NSURL(string: customURL)! as URL) {
            UIApplication.shared.open(NSURL(string: urlRoute)! as URL, options: [:], completionHandler: nil)
        } else {
            openAppleMapForPlace(lat: lat, long: long)
        }
    }
}

