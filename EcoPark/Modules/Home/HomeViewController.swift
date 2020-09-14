//
//  HomeViewController.swift
//  EnglishApp
//
//  Created Ngoc Duong on 10/22/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import GoogleMaps
import GooglePlaces

protocol HomeViewControllerDelegate: class {
    func showLefMenuTapped()
}

class HomeViewController: BaseViewController, HomeViewProtocol {
    
    var presenter: HomePresenterProtocol?
    @IBOutlet weak var vSearch: AppSearchBar!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var vParkingSort: ParkingSortView!
    @IBOutlet weak var btnFilter: UIButton!
    var marker:GMSMarker!
    
    var locationManager = CLLocationManager()
    var centerMapCoordinate:CLLocationCoordinate2D!
    
    weak var delegate: HomeViewControllerDelegate?
    
    var listParking = [ParkingEntity]()
    var parkingSelected: ParkingEntity?
    
    /****** Default param - Fix me later. *****/
    var star: [Int] = []
    var distance = "500"
    var address = ""
    /********************************/
    let zoomMap: Float = 14.0
    
    var isFirst: Bool = true
    
    // use check checkin and idCheckIn
    var idBookingCheckIn = ""
    var isHaveReserver: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // remove later
        setUpMap(lat: 10.7981483, long: 106.6715733)
        vParkingSort.isHidden = true
        
        //        getParking()
        
        btnFilter.setTitle(LocalizableKey.FilterHome.showLanguage, for: UIControl.State.normal)
    }
    
    
    
    func checkIconCheckInCheckOut() {
        self.idBookingCheckIn = ""
        self.isHaveReserver = false
        
        Provider.shared.parkingAPIService.getDoingBooking(success: { array in
            for booking in array {
                if booking.status == "checked_in" {
                    self.idBookingCheckIn = booking.id&
                }
                
                if booking.status& == StatusBooking.reservation.rawValue {
                    self.isHaveReserver = true
                }
            }
            
            if self.isHaveReserver  {
                 self.addButtonToNavigation(image: AppImage.iconCheckin, style: .right, action: #selector(self.btnCheckIn))
            } else {
                // have reserver
                if self.idBookingCheckIn != "" {
                    self.addButtonToNavigation(image: AppImage.iconCheckout, style: .right, action: #selector(self.btnCheckOut))
                } else {
                    self.navigationController?.navigationItem.rightBarButtonItem = nil
                }
                
            }
        }) { error in
            
        }
    }
    
    func getParking() {
        
        ProgressView.shared.show()
        Provider.shared.userAPIService.getParking(lat: centerMapCoordinate.latitude.description, long: centerMapCoordinate.longitude.description, star: self.star, distance: self.distance, success: { parking in
            ProgressView.shared.hide()
            self.listParking = parking
            self.drawMarker(parkings: self.listParking)
        }) { error in
            ProgressView.shared.hide()
        }
    }
    
    func setUpMap(lat: CLLocationDegrees = 0, long: CLLocationDegrees = 0) {
        centerMapCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.mapView?.isMyLocationEnabled = true
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        mapView.settings.myLocationButton = false
        mapView.delegate = self
        
        
        let camera = GMSCameraPosition.camera(withTarget: centerMapCoordinate, zoom: self.zoomMap)
        self.mapView?.animate(to: camera)
    }
    
    @IBAction func setMyLocation() {
        let camera = GMSCameraPosition.camera(withTarget: UserDefaultHelper.shared.myLocationCoordinate, zoom: self.zoomMap)
        self.mapView?.animate(to: camera)
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        addMenu()
        //        addButtonToNavigation(image: AppImage.iconCheckout, style: .right, action: #selector(btnCheckIn))
        setTitleBoldLeftNavigation(title: "ECOPARKING", action: nil)
        
        vParkingSort.btnOver.addTarget(self, action: #selector(showPopUpDetail), for: UIControl.Event.touchUpInside)
        vParkingSort.btnBooking.addTarget(self, action: #selector(btnBookingTapped), for: UIControl.Event.touchUpInside)
    }
    
    @objc func btnMyLocationTapped() {
        setMyLocation()
    }
    
    @objc func btnCheckOut() {
        let vc = CheckOutRouter.createModule(bookingId: self.idBookingCheckIn)
        self.push(controller: vc)
    }
    
    @objc func btnCheckIn() {
        let vc = AppQRScanerViewController.createModule(isCheckIn: true)
        vc.completionCode = { qrcode in
            guard let qrcode = qrcode as? [String] else { return }
            if qrcode.count > 2 {
                
                ProgressView.shared.show()
                
                Provider.shared.userAPIService.scanQRCheckIn(parkingId: qrcode[2], bossParkingId: qrcode[1], success: { bookingDetail in
                    ProgressView.shared.hide()
                    guard let bookingDetail = bookingDetail else { return }
                    
                    PopUpHelper.shared.showCheckIn(name: bookingDetail.fullname&, address: "Địa Chỉ", time: "12/12", width: 350, height: 220, completionYes: {
                        //---
                    }) {
                        //---
                    }
                    
                    //                    let vc = DetailParkingRouter.createModule(bookingDetailEntity: bookingDetail)
                    //                    self.push(controller: vc)
                    
                }) { error in
                    ProgressView.shared.hide()
                }
            }
        }
        
        self.push(controller: vc)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigation()
        
        setFilter()
        
        checkIconCheckInCheckOut()
        presenter?.getProfileUser()
        presenter?.getNumberHours()
    }
    
    func setFilter() {
        if address == "" {
                   btnFilter.isEnabled = false
               } else {
                   btnFilter.isEnabled = true
               }
    }
    
    override func setUpViews() {
        super.setUpViews()
        vSearch.setTitleAndPlaceHolder(icon: AppImage.iconPlaceMap, placeHolder: LocalizableKey.InputDestination.showLanguage)
        vSearch.tapToTextField = {
            let vc = HomeFindRouter.createModule(address: self.address)
            vc.delegate = self
            self.star = []
            
            self.push(controller: vc)
        }
    }
    
    @objc func showPopUpDetail() {
        guard isLogin() else {
            showLoginScreen()
            return
        }
        let popUp = ParkingDetailPopUp()
        let price = parkingSelected?.config_price ?? 1000
        
        popUp.showPopUp(width: popUpwidth, money: price, completionNo: nil, completionYes: {
            if let wallet = UserDefaultHelper.shared.loginUserInfo?.wallet, wallet >= price {
                let vc  = ParkingUserDetailRouter.createModule(parking: self.parkingSelected)
                self.push(controller: vc)
            } else {
                PopUpHelper.shared.showMessage(message: LocalizableKey.dontHaveMoney.showLanguage, width: self.popUpwidth) {
                    
                }
            }
            
        })
    }
    
    @IBAction func btnFilterTapped() {
        let popUp = HomeFilterPopUp()
        popUp.showPopUp(completionNo: {
            print("reset")
        }) { param in
            if let param = param as? NSArray {
                if let distance = param[0] as? Int, let star = param[1] as? [Int] {
                    self.star = star
                    self.distance = distance.description
                    self.getParking()
                }
            }
        }
    }
    
    @objc func btnBookingTapped() {
        if isLogin() {
            let price = parkingSelected?.price ?? 1000
            if let wallet = UserDefaultHelper.shared.loginUserInfo?.wallet, wallet >= price {
                let bookingInfo = BookingInfoRouter.createModule(parking: self.parkingSelected)
                self.push(controller: bookingInfo)
            } else {
                PopUpHelper.shared.showMessage(message: LocalizableKey.dontHaveMoney.showLanguage, width: self.popUpwidth) {
                    
                }
            }
            
        } else {
            showLoginScreen()
        }
    }
    
    func didGetProfileUser(user: UserEntity) {
        UserDefaultHelper.shared.saveUser(user: user)
        UserDefaultHelper.shared.parkingID = user.parkingID ?? ""
    }
}
extension HomeViewController: HomeFindViewControllerDelegate {
    func didSelectAddressSignUp(address: String, lat: CLLocationDegrees, long: CLLocationDegrees) {
        
    }
    
    func didSelectAddress(address: String, lat: CLLocationDegrees, long: CLLocationDegrees) {
        setUpMap(lat: lat, long: long)
        self.address = address
        self.vSearch.tfInput.text = address
        getParking()
    }
    
    func didSelectMyLocation() {
        print("did tap my location")
        btnFilter.isEnabled = true
        
        getAddressFromLocation(pdblLatitude: CGFloat(UserDefaultHelper.shared.myLocationCoordinate.latitude), withLongitude: CGFloat(UserDefaultHelper.shared.myLocationCoordinate.longitude))
        
        self.setMyLocation()
        self.getParking()
       
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isFirst {
            isFirst = false
            
            let location = locations.last
            self.centerMapCoordinate = location?.coordinate
            UserDefaultHelper.shared.myLocationCoordinate = self.centerMapCoordinate
            let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: self.zoomMap)
            
            self.mapView?.animate(to: camera)
            self.locationManager.stopUpdatingLocation()
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}


//MARK: - delegate map position
extension HomeViewController: GMSMapViewDelegate {
    func drawMarker(parkings: [ParkingEntity]) {
        mapView.clear()
        parkings.forEach { _project in
            DispatchQueue.main.async {
                GoogleMapHelper.shared.drawMarkerProject(parking: _project, mapView: self.mapView)
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapMyLocation location: CLLocationCoordinate2D) {
        print("location current")
    }
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        guard let marker = marker as? ProjectMarker else { return true}
        clearMap()
        marker.parking?.isSelected = true
        drawMarker(parkings: listParking)
        vParkingSort.parking = marker.parking
        parkingSelected = marker.parking
        vParkingSort.isHidden = false
        return true
    }
    
    func clearMap() {
        self.mapView.clear()
        listParking.forEach { parking in
            parking.isSelected = false
        }
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        //        let latitude = mapView.camera.target.latitude
        //        let longitude = mapView.camera.target.longitude
        //        centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        //        self.placeMarkerOnCenter(centerMapCoordinate:centerMapCoordinate)
        //        print(centerMapCoordinate)
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        //        print(mapView.camera.target)
        //        print(position.target)
        //        let long = CGFloat(position.target.longitude)
        //        let lat = CGFloat(position.target.latitude)
        //        if isTextfieldDelegate {
        //            isTextfieldDelegate = false
        //        } else {
        //            getAddressFromLocation(pdblLatitude: lat, withLongitude: long)
        //        }
        //
        //        guard let distance = self.distance else { return }
        //        presenter?.getCountRecord(long: long, lat: lat, radius: Int(distance.value&))
        
        
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        //        vTitleMarker.isHidden = true
    }
    
    func placeMarkerOnCenter(centerMapCoordinate:CLLocationCoordinate2D) {
        if marker == nil {
            marker = GMSMarker()
        }
        
        marker.position = centerMapCoordinate
        marker.map = self.mapView
    }
    
    
    func getAddressFromLocation(pdblLatitude: CGFloat, withLongitude pdblLongitude: CGFloat) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        centerMapCoordinate = center
        
        var resultAddress: String = ""
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        var addressString : String = ""
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                
                guard let pm = placemarks  else { return }
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    print(addressString)
                    
                    resultAddress =  addressString
                }
                self.vSearch.tfInput.text = resultAddress
                self.address = resultAddress
                self.setFilter()
        })
       
    }
}

extension HomeViewController {
    private func isLogin() -> Bool {
        if UserDefaultHelper.shared.isLogedIn {
            return true
        }
        return false
    }
    
    private func showLoginScreen() {
        present(controller: UINavigationController(rootViewController: LoginRouter.createModule()))
    }
}
