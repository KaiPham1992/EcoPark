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
    
    var iconUrl: URL? {
        return URL(string: "\(BASE_URL_IMAGE)\(icon&)")
    }
    
    var iconUnsetUrl: URL? {
        return URL(string: "\(BASE_URL_IMAGE)\(unset_icon&)")
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.id <- map["_id"]
        self.name <- map["name"]
        if name == nil {
            self.name <- map["_key"]
        }
        self.isActive <- map["isActive"]
        self.icon <- map["icon"]
        self.unset_icon <- map["unset_icon"]
    }
}
