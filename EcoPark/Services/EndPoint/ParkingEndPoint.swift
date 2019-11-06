//
//  ParkingEndPoint.swift
//  EcoPark
//
//  Created by Henry on 11/6/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Alamofire

enum ParkingEndPoint {
    case getParkingInfo(id: String)
}

extension ParkingEndPoint: EndPointType {
    
    var path: String {
        switch self {
        case .getParkingInfo:
            return "_api/parking/get_parking_info"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getParkingInfo(let id):
            return ["parking_id": id]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
