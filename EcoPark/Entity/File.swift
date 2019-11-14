//
//  File.swift
//  EcoPark
//
//  Created by Ngoc Duong on 11/5/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

struct GoogleLocationEntity: Mappable  {
    var placeID: String = ""
    var address: String?
    var structuredFormatting:StructuredFormatting?
    var matchedSubstrings:MatchedSubstrings?
    
    init?(map: Map) {
    }
    
    init() {
        
    }
    
    mutating func mapping(map: Map) {
        self.placeID <- map["place_id"]
        self.address <- map["description"]
        self.structuredFormatting <- map["structured_formatting"]
        self.matchedSubstrings <- map["matched_substrings"]
    }
    func getPlaceName() -> String {
        return structuredFormatting?.mainText ?? ""
    }
    func getPlaceAddress() -> String {
        return structuredFormatting?.secondaryText ?? ""
    }
}

struct StructuredFormatting:Mappable {
    var mainText: String?
    var secondaryText:String?
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.mainText <- map["main_text"]
        self.secondaryText <- map["secondary_text"]
    }
}
struct MatchedSubstrings:Mappable {
    var lenght: Int = 0
    var offset: Int = 0
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.lenght <- map["lenght"]
        self.offset <- map["offset"]
    }
}
