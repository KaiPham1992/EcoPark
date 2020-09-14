//
//  Notification.swift
//  Oganban
//
//  Created by Kai Pham on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//


import ObjectMapper

class NotificationEntity: BaseEntity {
    var id: String?
    var title: String?
    var content: String?
    
    var isReadString: String?
    var isRead: Bool?
    var readTime: Date?
    var createTime: Date?
    
    var actionKey: String?
    var screen: String?
    var objectId: String?
    var url: URL?
    var bookingID: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.id <- map["_id"]
        self.title <- map["title"]
        self.content <- map["_content"]
        self.createTime <- (map["create_time_mi"], AppTimestampTransform())
        self.isRead <- map["is_read"]
        self.isReadString <- map["is_read"]
        self.isRead =  self.isReadString == "1"
        self.actionKey <- map["action_key"]
        self.screen <- map["screen"]
        self.objectId <- map["obj_id"]
        self.bookingID <-  map["booking_id"]
    }
    
    required init?(map: Map) {
        super.init()
    }
}

