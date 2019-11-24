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
    case cancelReservation(bookingId: String)
    case extendReservation(bookingId: String)
    case ratingBooking(bookingId: String, rating: String)
}

extension BookingEndPoint: EndPointType {
    var path: String {
        switch self {
        case .booking:
            return "_api/order/get_booking"
        case .getBookingDetail:
            return "_api/order/get_booking_detail"
        case .cancelReservation:
            return "_api/order/update_status_booking"
        case .extendReservation:
            return "_api/order/extra_reservation"
        case .ratingBooking:
            return "_api/order/rating_booking"
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
        case .cancelReservation(let id):
            return ["booking_id": id, "status": "cancel"]
        case .extendReservation(let id):
            return ["booking_id": id]
        case .ratingBooking(let bookingId, let rating):
            return ["booking_id" : bookingId, "rating" : rating]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
