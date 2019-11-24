//
//  RatingEntity.swift
//  EcoPark
//
//  Created by Ngoc Duong on 11/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import ObjectMapper

class RatingEntity:  BaseEntity {
    var rating: Int?
    var total_rating: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.rating <- (map["rating"], StringToIntTransform())
        self.total_rating <- (map["total_rating"], StringToIntTransform())
    }
}
