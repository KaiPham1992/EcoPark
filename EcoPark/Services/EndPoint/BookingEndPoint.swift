//
//  BookingEndPoint.swift
//  EcoPark
//
//  Created by Henry Tran on 11/19/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Alamofire

enum BookingEndPoint {
    case booking(time: String, parkingId: String, vehicleId: String, plate: String, moneyPaid: String)
    case getBookingDetail(bookingId: String)
}

extension BookingEndPoint: EndPointType {
    var path: String {
        switch self {
        case .booking:
            return "_api/order/get_booking"
        case .getBookingDetail:
            return "_api/order/get_booking_detail"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .booking(let time, let parkId, let vehicleId, let plate, let money):
            return ["intend_checkin_time": time, "parking_id": parkId, "vehicle_id": vehicleId, "license_plates": plate, "money_paid": money]
        case .getBookingDetail(let bookingId):
            return ["booking_id": bookingId]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
