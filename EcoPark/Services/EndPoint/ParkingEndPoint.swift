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
    case getMaterial
    case bossRegister(param: BossRegisterParam)
    case updateInfoParking(param: UpdateInfoParkingParam)
    case uploadImageParking(parkingID: String, parkingImage: [String])
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
        case .getMaterial:
            return "_api/parking/get_list_material"
        case .bossRegister:
            return "_api/user/register_boss"
        case .updateInfoParking:
            return "_api/parking/update_info_parking"
        case .uploadImageParking:
            return "_api/parking/update_img_parking"
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
        case .getMaterial:
            return [:]
        case .bossRegister(let param):
            return param.toJSON()
        case .updateInfoParking(let param):
            return param.toJSON()
        case .uploadImageParking(let parkingID, let parkingImage):
            return ["parking_id": parkingID, "parking_img_src" : parkingImage]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
