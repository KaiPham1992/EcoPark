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
    var marker:GMSMarker!
    
    var locationManager = CLLocationManager()
    var centerMapCoordinate:CLLocationCoordinate2D!
    
    var myLocationCoordinate:CLLocationCoordinate2D!
    
    weak var delegate: HomeViewControllerDelegate?
    
    var listParking = [ParkingEntity]()
    var parkingSelected: ParkingEntity?
    
    /****** Default param - Fix me later. *****/
    var star: [Int] = [1,2,3,4,5]
    var distance = "1000"
    var address = "chung cư 8x plus"
    /********************************/
    
    var isFirst: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // remove later
        setUpMap(lat: 10.7981483, long: 106.6715733)
        vParkingSort.isHidden = true
        
        getParking()
    }
    
    func getParking() {
        ProgressView.shared.show()
        Provider.shared.userAPIService.getParking(address: self.address, star: self.star, distance: self.distance, success: { parking in
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
        
        
        let camera = GMSCameraPosition.camera(withTarget: centerMapCoordinate, zoom: 16)
        self.mapView?.animate(to: camera)
    }
    
    @IBAction func setMyLocation() {
        let camera = GMSCameraPosition.camera(withTarget: myLocationCoordinate, zoom: 16)
        self.mapView?.animate(to: camera)
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        addMenu()
        addButtonToNavigation(image: AppImage.iconCheckout, style: .right, action: #selector(btnCheckIn))
        setTitleBoldLeftNavigation(title: "ECOPARKING", action: nil)
        
        vParkingSort.btnOver.addTarget(self, action: #selector(showPopUpDetail), for: UIControl.Event.touchUpInside)
        vParkingSort.btnBooking.addTarget(self, action: #selector(btnBookingTapped), for: UIControl.Event.touchUpInside)
    }
    
    @objc func btnMyLocationTapped() {
        setMyLocation()
    }
    
    @objc func btnCheckIn() {
        let checkIn = QRScannerRouter.createModule()
        self.push(controller: checkIn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigation()
    }
    
    override func setUpViews() {
        super.setUpViews()
        vSearch.setTitleAndPlaceHolder(icon: AppImage.iconPlaceMap, placeHolder: "Nhập điểm đến")
        vSearch.tapToTextField = {
            let vc = HomeFindRouter.createModule()
            vc.delegate = self
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
                PopUpHelper.shared.showMessage(message: "Bạn không đủ tiền trong ví", width: self.popUpwidth)
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
            let bookingInfo = BookingInfoRouter.createModule(parking: self.parkingSelected)
            self.push(controller: bookingInfo)
        } else {
            showLoginScreen()
        }
    }
    
}
extension HomeViewController: HomeFindViewControllerDelegate {
    func didSelectAddressSignUp(address: String, lat: CLLocationDegrees, long: CLLocationDegrees) {
        
    }
    
    func didSelectAddress(address: String, lat: CLLocationDegrees, long: CLLocationDegrees) {
        setUpMap(lat: lat, long: long)
        self.address = address
        getParking()
    }
    
    func didSelectMyLocation() {
        print("did tap my location")
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isFirst {
            isFirst = false
            
            let location = locations.last
            self.centerMapCoordinate = location?.coordinate
            myLocationCoordinate = location?.coordinate
            let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 16.0)
            
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
    
    
    func getAddressFromLocation(pdblLatitude: CGFloat, withLongitude pdblLongitude: CGFloat) -> String {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
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
        })
        
        return resultAddress
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
