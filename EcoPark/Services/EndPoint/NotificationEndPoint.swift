//
//  NotificationEndPoint.swift
//  Oganban
//
//  Created by Kai Pham on 12/26/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import Alamofire

enum NotificationEndPoint {
    case getNotification(offset: Int, limit: Int, screen: String)
    case readNotification(notificationId: Int)
    case getNotificationDetail(id: Int)
}

extension NotificationEndPoint: EndPointType {
    var path: String {
        switch self {
        case .getNotification:
            return "_api/notification/get_notification_list"
        case .readNotification:
            return "_api/notification/read_notifications"
        case .getNotificationDetail(let id):
            return "_api/notification/get_notification_detail/\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getNotificationDetail:
            return .get
        default:
            return .post
        }
       
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getNotification(let offset, let limit, let screen):
            return ["offset": "\(offset)", "limit": limit, "screen": screen]
        case .readNotification(let id):
            return ["notification_ids": [id]]
        case .getNotificationDetail:
            return [:]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
