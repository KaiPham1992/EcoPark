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
    case getListVehicle
    case booking(time: String, parkingId: String, vehicleId: String, plate: String, moneyPaid: String)
    case getBookingDetail(bookingId: String)
    case getParkingType
}

extension ParkingEndPoint: EndPointType {
    
    var path: String {
        switch self {
        case .getParkingInfo:
            return "_api/parking/get_parking_info"
        case .getListVehicle:
            return "_api/parking/get_list_vehicle"
        case .booking:
            return "_api/order/get_booking"
        case .getBookingDetail:
            return "_api/order/get_booking_detail"
        case .getParkingType:
            return "_api/parking/get_list_parking_type"
        }
        
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getParkingInfo(let id):
            return ["parking_id": id]
        case .getListVehicle:
            return [:]
        case .booking(let time, let parkId, let vehicleId, let plate, let money):
            return ["intend_checkin_time": time, "parking_id": parkId, "vehicle_id": vehicleId, "license_plates": plate, "money_paid": money]
        case .getBookingDetail(let bookingId):
            return ["booking_id": bookingId]
        case .getParkingType:
            return [:]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
