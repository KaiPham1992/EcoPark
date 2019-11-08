//
//  VehicleType.swift
//  EcoPark
//
//  Created by Henry on 11/8/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper
class VehicleTypeEntity: BaseEntity {
    var id: String?
    var name: String?
    var isActive: Bool?
    var icon: String?
    var unset_icon: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
    
        self.id <- map["_id"]
        self.name <- map["name"]
        self.isActive <- map["isActive"]
        self.icon <- map["icon"]
        self.unset_icon <- map["unset_icon"]
    }
}
