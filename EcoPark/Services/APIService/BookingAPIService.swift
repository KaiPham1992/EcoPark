//
//  BookingAPIService.swift
//  EcoPark
//
//  Created by Henry Tran on 11/19/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

protocol BookingAPIServiceProtocol {
    func booking(time: String, parkId: String, vehicleId: String, plate: String, moneyPaid: String, success: @escaping SuccessHandler<BookingEntity>.object, failure: @escaping RequestFailure)
    func getBookingDetail(bookingId: String, success: @escaping SuccessHandler<BookingDetailEntity>.object, failure: @escaping RequestFailure)
    
}

class BookingAPIService: BookingAPIServiceProtocol {
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func booking(time: String, parkId: String, vehicleId: String, plate: String, moneyPaid: String, success: @escaping SuccessHandler<BookingEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = BookingEndPoint.booking(time: time, parkingId: parkId, vehicleId: vehicleId, plate: plate, moneyPaid: moneyPaid)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getBookingDetail(bookingId: String, success: @escaping SuccessHandler<BookingDetailEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = BookingEndPoint.getBookingDetail(bookingId: bookingId)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
