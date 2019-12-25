//
//  UserAPIService.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 10/10/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import Foundation
import UIKit

protocol UserAPIServiceProtocol {
    func login(username: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    func forgotPassword(email: String, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    func checkLogin(success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    func getCaptcha(success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    func logout(success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure)
    
    func loginGmail(param: LoginSocialParam, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    
    func loginFacebook(fbEntity: FacebookEntity, phone: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    
    func changePassword(current: String, new: String, success: @escaping SuccessHandler<BaseResponseString>.object, failure: @escaping RequestFailure)
    
    func verifyPhone(code: String, phone: String, phonCode: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    func signUp(param: SignUpParam, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    
    func updateProfile(param: UpdateProfileParam, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    
    func updateProfileSocial(param: UpdateProfileSocial, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    func uploadAvatar(image: UIImage, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    
    func getProfileUser(success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure)
    
    func getParking(lat: String, long: String, star: [Int], distance: String, success: @escaping SuccessHandler<ParkingEntity>.array, failure: @escaping RequestFailure)
    
    func getWallet(success: @escaping SuccessHandler<WalletEntity>.object, failure: @escaping RequestFailure)
    
    func getWalletHistory(startDate: String, toDate: String, offset: Int, limit: Int, success: @escaping SuccessHandler<WalletEntity>.object, failure: @escaping RequestFailure)
    
    func scanQRCheckIn(parkingId: String, bossParkingId: String, success: @escaping SuccessHandler<BookingDetailEntity>.object, failure: @escaping RequestFailure)
    
    func scanQRCheckOut(bookingId: String, code: String, licensePlates: String, success: @escaping SuccessHandler<BookingDetailEntity>.object, failure: @escaping RequestFailure)
  
}


class UserAPIService: UserAPIServiceProtocol {
    
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func login(username: String, password: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.login(username: username, password: password)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    func forgotPassword(email: String, success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endpoint = UserEndPoint.fogotPassword(email: email)
        network.requestData(endPoint: endpoint, success: MapperData.mapNoData(success), failure: failure)
    }
    func checkLogin(success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.checkLogin
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getCaptcha(success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.getCaptcha
        network.requestData(endPoint: endPoint, success: MapperData.mapNoData(success), failure: failure)
    }
    
    func logout(success: @escaping SuccessHandler<BaseResponse>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.logout
        network.requestData(endPoint: endPoint, success: MapperData.mapNoData(success), failure: failure)
    }
    
    func loginGmail(param: LoginSocialParam, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.loginGmail(loginSocialParam: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func loginFacebook(fbEntity: FacebookEntity, phone: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.loginFacebook(fbEntity: fbEntity, phone: phone)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func signUp(param: SignUpParam, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.signUp(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func changePassword(current: String, new: String, success: @escaping SuccessHandler<BaseResponseString>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.changePassword(current: current, new: new)
        network.requestData(endPoint: endPoint, success: MapperData.mapNoData(success), failure: failure)
    }
    
    func updateProfile(param: UpdateProfileParam, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.updateProfile(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func verifyPhone(code: String, phone: String, phonCode: String, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.verifyPhone(code: code, phone: phone, phoneCode: phonCode)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func updateProfileSocial(param: UpdateProfileSocial, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.updateProfileSocial(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func uploadAvatar(image: UIImage, success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.uploadAvatar
        network.uploadAvatar(image: image, endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    
    func getProfileUser(success: @escaping SuccessHandler<UserEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.getProfileUser
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    // Eco park
    func getParking(lat: String, long: String, star: [Int], distance: String, success: @escaping SuccessHandler<ParkingEntity>.array, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.getParking(lat: lat, long: long, star: star, distance: distance)
        network.requestData(endPoint: endPoint, success: MapperData.mapArray(success), failure: failure)
    }
    
    func getWallet(success: @escaping SuccessHandler<WalletEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.getWallet
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func getWalletHistory(startDate: String, toDate: String, offset: Int, limit: Int, success: @escaping SuccessHandler<WalletEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.getWalletHistory(startDate: startDate, toDate: toDate, offset: offset, limit: limit)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func scanQRCheckIn(parkingId: String, bossParkingId: String, success: @escaping SuccessHandler<BookingDetailEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.scanQRCheckIn(parkingId: parkingId, bossParkingId: bossParkingId)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
    func scanQRCheckOut(bookingId: String, code: String, licensePlates: String, success: @escaping SuccessHandler<BookingDetailEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.scanQRCheckOut(bookingId: bookingId, code: code, licensePlates: licensePlates)
        network.requestData(endPoint: endPoint, success: MapperData.mapObject(success), failure: failure)
    }
    
}


