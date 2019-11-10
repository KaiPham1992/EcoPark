//
//  UpdateProfileParam.swift
//  Oganban
//
//  Created by Kent on 1/21/19.
//  Copyright © 2019 Coby. All rights reserved.
//

import ObjectMapper

class UpdateProfileParam: BaseParam {
    
    var username        : String?
    var fullname        : String?
    var email       : String?
    var phone       : String?
    var gender      : String?
    var birthday    : String?
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.username        <- map["username"]
        self.fullname        <- map["fullname"]
        self.email       <- map["email"]
        self.phone       <- map["phone"]
        self.gender      <- map["gender"]
        self.birthday    <- map["birthday"]
    }
    
    init(username: String?, fullname: String?, email: String?, phone: String?, gender: String?, birthDay: String?) {
        super.init()
        self.fullname    = fullname
        self.username    = username
        self.email       = email
        self.phone       = phone
        self.gender      = gender
        self.birthday    = birthDay
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}

