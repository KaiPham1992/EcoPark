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
    
    var account_id: String?
    var fullname: String?
    var parking_id: String?
    var address: String?
    var number_place: String?
    var time_start: Date?
    var time_end: Date?
    var package_price: Double?
    var package_number: Double?
    var price: Double?
    var rating: Double?
    var gender: String?
    var phone: String?
    var parking_name: String?
    var distance: String?
    var img_parking: ImageParkingEntity?
    var config_price: Double? = 1000
    var total_rating: String?
    var parking_type_name: String?
    
    var url: URL? {
        guard let strImage = img_parking?.imgParking else { return nil }
        return URL(string: "\(BASE_URL_IMAGE)\(strImage)")
    }
    
    init(lat: Double, long: Double) {
        super.init()
        self.lat = lat
        self.long = long
    }
    
    init(id: String) {
        super.init()
        self.parking_id = id
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.account_id <- map["account_id"]
        self.fullname <- map["fullname"]
        self.parking_id <- map["parking_id"]
        self.address <- map["address"]
        self.lat <- (map["lat"], StringToDoubleTransform())
        self.long <- (map["long"], StringToDoubleTransform())
        self.number_place <- map["number_place"]
        self.time_start <- (map["time_start"], AppTimestampTransform())
        self.time_end <- (map["time_end"], AppTimestampTransform())
        self.package_price <- (map["package_price"], StringToDoubleTransform())
        self.package_number <- (map["package_number"], StringToDoubleTransform())
        self.config_price <- (map["config_price"], StringToDoubleTransform())
        self.price <- (map["price"], StringToDoubleTransform())
        self.rating <- (map["rating"], StringToDoubleTransform())
        print("*************")
        print(rating)
        self.gender <- map["gender"]
        self.phone <- map["phone"]
        self.parking_name <- map["parking_name"]
        self.distance <- map["distance"]
        self.img_parking <- map["img_parking"]
        self.total_rating <- map["total_rating"]
        self.parking_type_name <- map["parking_type_name"]
    }
    
    required init?(map: Map) {
//        fatalError("init(map:) has not been implemented")
        super.init(map: map)
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

class ImageParkingEntity: BaseEntity {
    var imgParking: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.imgParking <- map["img_parking"]
    }
}
