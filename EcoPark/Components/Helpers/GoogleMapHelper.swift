//
//  GoogleMapHelper.swift
//  RedStar
//
//  Created by Ngoc Duong on 11/17/18.
//  Copyright © 2018 DINH VAN TIEN. All rights reserved.
//

import GoogleMaps

class GoogleMapHelper: NSObject {
    static let shared = GoogleMapHelper()
    
    func drawMarkerProject(parking: ParkingEntity, mapView: GMSMapView) {
        guard let lat = parking.lat, let long = parking.long else { return }
               
        let position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        print("lat: \(lat), long: \(long)")
        // add new
//        let marker = ProjectMarker(position: position)
//        marker.markerProjectView = MarkerProjectView()
//        marker.markerProjectView?.parking = parking
//        marker.iconView = marker.markerProjectView
//        marker.tracksViewChanges = true
//        marker.map = mapView
        let marker = ProjectMarker(position: position)
        marker.parking = parking
        marker.title = ""
        marker.icon = AppImage.imgParking
        if parking.isSelected {
            marker.icon = AppImage.imgMarkerSelected
        }
        
        marker.map = mapView
    }
}