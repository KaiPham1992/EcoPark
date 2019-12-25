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
    func getParkingType(success: @escaping SuccessHandler<ParkingTypeEntity>.array, failure: @escaping RequestFailure)
    func getMaterial(success: @escaping SuccessHandler<MaterialEntity>.array, failure: @escaping RequestFailure)
    func bossRegister(param: BossRegisterParam, success: @escaping SuccessHandler<ParkingInfoEntity>.object, failure: @escaping RequestFailure)
    func updateInfoParking(param: UpdateInfoParkingParam, success: @escaping SuccessHandler<ParkingInfoEntity>.object, failure: @escaping RequestFailure)
    func uploadImageParking(parkingID: String, ParkingImage: [String], success: @escaping SuccessHandler<ImgEntity>.array, failure: @escaping RequestFailure)
    func getDoingBooking(success: @escaping SuccessHandler<HistoryBookingParkingResponse>.array, failure: @escaping RequestFailure)
    func getHistoryBooking(success: @escaping SuccessHandler<HistoryBookingParkingResponse>.array, failure: @escaping RequestFailure)
    func getHistoryMyParking(parkingID: String, status: String, keyword: String, offset: Int, limit: Int, success: @escaping SuccessHandler<HistoryMyParkingEntity>.object, failre: @escaping RequestFailure)
    func getHistoryParkingDetail(parkingID: String, bookingID: String, success: @escaping SuccessHandler<HistoryBookingParkingResponse>.object, failure: @escaping RequestFailure)
    func checkoutParking(bookingID: String, code: String, license_plates: String, success: @escaping SuccessHandler<HistoryBookingParkingResponse>.object, failure: @escaping RequestFailure)
    func changeStatusParking(parkingID: String, isActive: String, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
}

class ParkingAPIService: ParkingAPIServiceProtocol {
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func getDoingBooking(success: @escaping SuccessHandler<HistoryBookingParkingResponse>.array, failure: @escaping RequestFailure) {
        let endPoint = ParkingEndPoint.getDoingBooking
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getHistoryBooking(success: @escaping SuccessHandler<HistoryBookingParkingResponse>.array, failure: @escaping RequestFailure) {
        let endPoint = ParkingEndPoint.getHistoryBooking
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getParkingInfo(id: String, success: @escaping SuccessHandler<ParkingInfoEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = ParkingEndPoint.getParkingInfo(id: id)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getListVehicle(success: @escaping SuccessHandler<VehicleTypeEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = ParkingEndPoint.getListVehicle
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }

    func getParkingType(success: @escaping SuccessHandler<ParkingTypeEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = ParkingEndPoint.getParkingType
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getMaterial(success: @escaping SuccessHandler<MaterialEntity>.array, failure: @escaping RequestFailure) {
        
    }
    
    func bossRegister(param: BossRegisterParam, success: @escaping SuccessHandler<ParkingInfoEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = ParkingEndPoint.bossRegister(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }

    func updateInfoParking(param: UpdateInfoParkingParam, success: @escaping SuccessHandler<ParkingInfoEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = ParkingEndPoint.updateInfoParking(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func uploadImageParking(parkingID: String, ParkingImage: [String], success: @escaping SuccessHandler<ImgEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = ParkingEndPoint.uploadImageParking(parkingID: parkingID, parkingImage: ParkingImage)
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getHistoryMyParking(parkingID: String, status: String, keyword: String, offset: Int, limit: Int, success: @escaping SuccessHandler<HistoryMyParkingEntity>.object, failre: @escaping RequestFailure) {
        let endPoint = ParkingEndPoint.getHistoryMyParking(parkingID: parkingID, status: status, keyword: keyword, offset: offset, limit: limit)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failre)
    }
    
    func getHistoryParkingDetail(parkingID: String, bookingID: String, success: @escaping SuccessHandler<HistoryBookingParkingResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = ParkingEndPoint.getHistoryParkingDetail(parkingID: parkingID, bookingID: bookingID)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func checkoutParking(bookingID: String, code: String, license_plates: String, success: @escaping SuccessHandler<HistoryBookingParkingResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = ParkingEndPoint.checkoutParking(bookingID: bookingID, code: code, license_plates: license_plates)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func changeStatusParking(parkingID: String, isActive: String, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = ParkingEndPoint.changeStatusParking(parkingID: parkingID, isActive: isActive)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
}
