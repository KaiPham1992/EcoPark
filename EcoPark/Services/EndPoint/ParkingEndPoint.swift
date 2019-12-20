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
    case getParkingType
    case getMaterial
    case bossRegister(param: BossRegisterParam)
    case updateInfoParking(param: UpdateInfoParkingParam)
    case uploadImageParking(parkingID: String, parkingImage: [String])
    case getDoingBooking
    case getHistoryBooking
    case getHistoryMyParking(parkingID: String, status: String, keyword: String)
    case getHistoryParkingDetail(parkingID: String, bookingID: String)
    case checkoutParking(bookingID: String, code: String, license_plates: String)
    case changeStatusParking(parkingID: String, isActive: String)
}

extension ParkingEndPoint: EndPointType {
    
    var path: String {
        switch self {
        case .getParkingInfo:
            return "_api/parking/get_parking_info"
        case .getListVehicle:
            return "_api/parking/get_list_vehicle"
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
        case .getDoingBooking:
            return "_api/order/get_list_booking"
        case .getHistoryBooking:
            return "_api/order/get_list_history_booking"
        case .getHistoryMyParking:
            return "_api/order/get_list_history_booking_parking"
        case .getHistoryParkingDetail:
            return "_api/order/get_detail_history_booking_parking"
        case .checkoutParking:
            return "_api/user/scan_qr_checkout"
        case .changeStatusParking:
            return "_api/parking/change_status_parking"
        }
        
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getDoingBooking, .getHistoryBooking:
            return [:]
        case .getParkingInfo(let id):
            return ["parking_id": id]
        case .getListVehicle:
            return [:]
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
        case .getHistoryMyParking(let parkingID, let status, let keyword):
            return ["parking_id": parkingID, "status": status, "keyword": keyword]
        case .getHistoryParkingDetail(let parkingID, let bookingID):
            return ["parking_id": parkingID, "booking_id": bookingID]
        case .checkoutParking(let bookingID, let code, let license_plates):
            return ["booking_id": bookingID, "code": code, "license_plates": license_plates]
        case .changeStatusParking(let parkingID, let isActive):
            return ["parking_id": parkingID, "is_active": isActive]
        }
    }
    
    var headers: HTTPHeaders? {
        let header = DefaultHeader().addAuthHeader()
        return header
    }
}
