//
//  ParkingAPIService.swift
//  EcoPark
//
//  Created by Henry on 11/6/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

protocol ParkingAPIServiceProtocol {
    func getParkingInfo(id: String, success: @escaping SuccessHandler<ParkingInfoEntity>.object, failure: @escaping RequestFailure)
    func getListVehicle(success: @escaping SuccessHandler<VehicleTypeEntity>.array, failure: @escaping RequestFailure)
    
}

class ParkingAPIService: ParkingAPIServiceProtocol {
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getParkingInfo(id: String, success: @escaping SuccessHandler<ParkingInfoEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = ParkingEndPoint.getParkingInfo(id: id)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getListVehicle(success: @escaping SuccessHandler<VehicleTypeEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = ParkingEndPoint.getListVehicle
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }

}
