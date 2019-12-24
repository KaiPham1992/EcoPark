//
//  ParkingTypeEntity.swift
//  EcoPark
//
//  Created by Tu DV on 11/13/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper

class ParkingTypeEntity: BaseEntity {
   var _id: String?
   var name: String?
   var plain_name: String?
   var is_active: String?
    var key: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
    
        self._id <- map["_id"]
        self.name <- map["name"]
        self.plain_name <- map["plain_name"]
        self.is_active <- map["is_active"]
        self.key <- map["_key"]
    }
}
