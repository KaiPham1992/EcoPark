//
//  ParkingEntity.swift
//  EnglishApp
//
//  Created by Ngoc Duong on 10/28/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper
import GoogleMaps

class ParkingEntity: BaseEntity {
    var lat: Double?
    var long: Double?
    var isSelected: Bool = false
    
    init(lat: Double, long: Double) {
        super.init()
        self.lat = lat
        self.long = long
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
    
    func toCLLocationCoordinate2D() -> CLLocationCoordinate2D? {
        guard let _lat = self.lat, let _long = self.long  else { return  nil}
        return CLLocationCoordinate2D(latitude: _lat, longitude: _long)
    }
    
    static func toArray() -> [ParkingEntity] {
        var parks = [ParkingEntity]()
        parks.append(ParkingEntity(lat:  10.7981483, long: 106.7))
        parks.append(ParkingEntity(lat:  10.7981483, long: 106.8715733))
        parks.append(ParkingEntity(lat:  10.9981483, long: 106.6715733))
        parks.append(ParkingEntity(lat:  10.7981483, long: 106.6715733))
                
        return parks
    }
}
