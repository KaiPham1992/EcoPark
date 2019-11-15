//
//  Network.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 9/27/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//
//
import Foundation
import ObjectMapper
import SwiftyJSON

/***
 Input: endPoint (all info to request)
 Ouput: BaseResponse or error
 ***/

protocol APINetworkProtocol {
    func requestData(endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure)
    func uploadImages(image: UIImage, endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure)
    func uploadAvatar(image: UIImage, endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure)
    func upload(_ endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure)
}

struct APINetwork: APINetworkProtocol {
    let request: NetworkRequestProtocol
    
    init(request: NetworkRequestProtocol) {
        self.request = request
    }
    
    func requestData(endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure) {
        print("✳️ URL: \(BASE_URL)\(endPoint.path)")
        print("✳️ Param: \(endPoint.parameters)")
        print("✳️ Header: \(endPoint.headers)")
        
//        /** Mock data - Remove me later */
//        if endPoint.path == "_api/order/get_booking_detail" {
//            if let path = Bundle.main.path(forResource: "test", ofType: "json") {
//                do {
//                      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                      let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//                    if let json = json as? Dictionary<String, AnyObject> {
//                        print(json)
//                        guard let result = Mapper<BaseResponse>().map(JSONObject: json) else {
//                            failure(APPError.canNotParseData)
//                            return
//                        }
//                        
//                        self.handleResponse(response: result, success: success, failure: failure)
//                    }
//                    
//                  } catch {
//                       // handle error
//                  }
//            }
//            return
//        }
//        if endPoint.path == "_api/order/get_booking" {
//            if let path = Bundle.main.path(forResource: "testBooking", ofType: "json") {
//                do {
//                      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                      let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
//                    if let json = json as? Dictionary<String, AnyObject> {
//                        print(json)
//                        guard let result = Mapper<BaseResponse>().map(JSONObject: json) else {
//                            failure(APPError.canNotParseData)
//                            return
//                        }
//                        
//                        self.handleResponse(response: result, success: success, failure: failure)
//                    }
//                    
//                  } catch {
//                       // handle error
//                  }
//            }
//            return
//        }
        /** End mock data*/
        
        request.requestData(endPoint: endPoint, success: { data in
            let json = JSON(data)
            
            if json.description == "null" {
                print("\n⛔⛔⛔⛔⛔⛔ ERROR ⛔⛔⛔⛔⛔⛔")
                print(String(data: data, encoding: .utf8))
                print("⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔")
            } else {
                print("\n✅✅✅✅✅✅✅ SUCCESS ✅✅✅✅✅✅✅")
                print(json)
                print("✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅")
            }
            
            
            guard let result = Mapper<BaseResponse>().map(JSONObject: json.dictionaryObject) else {
                failure(APPError.canNotParseData)
                return
            }
            
            self.handleResponse(response: result, success: success, failure: failure)
            
        }) { error in
            print("APINetwork - requestData: \(String(describing: error?.code?.description&))")
            failure(APIError(error: error))
        }
    }
    
    func uploadAvatar(image: UIImage, endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure) {
        print(endPoint.parameters)
        
        print("✳️ URL: \(BASE_URL)\(endPoint.path)")
        print("✳️ Param: \(endPoint.parameters)")
        print("✳️ Header: \(endPoint.headers)")
        
        request.uploadAvatar(image: image, endPoint: endPoint, success: { data in
            let json = JSON(data)
            print(json)
            
            guard let result = Mapper<BaseResponse>().map(JSONObject: json.dictionaryObject) else {
                failure(APPError.canNotParseData)
                return
            }
            
            self.handleResponse(response: result, success: success, failure: failure)
        }) { error in
            print("APINetwork - uploadImages: \(String(describing: error?.code?.description&))")
            failure(APIError(error: error))
        }
    }
    
    func uploadImages(image: UIImage, endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure) {
        print(endPoint.parameters)
        
        request.uploadImages(image: image, endPoint: endPoint, success: { data in
            let json = JSON(data)
            print(json)
            
            guard let result = Mapper<BaseResponse>().map(JSONObject: json.dictionaryObject) else {
                failure(APPError.canNotParseData)
                return
            }
            
            self.handleResponse(response: result, success: success, failure: failure)
        }) { error in
            print("APINetwork - uploadImages: \(String(describing: error?.code?.description&))")
            failure(APIError(error: error))
        }
    }
    
    func upload(_ endPoint: EndPointType, success: @escaping NetworkSuccess, failure: @escaping RequestFailure) {
        
//        self.checkTokenValid()
        
//        request.upload(endPoint, success: { data in
//            let response = Response(data: data)
//            if let error = ApiError(response: response) {
//                if error.code == StatusCode.tokenInvalid.rawValue {
//                    self.refreshToken()
//                } else {
//                    self.showAlert(error: error, isShowAlert: true)
//                }
//                failure(error)
//            } else {
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary {
//                        success(json)
//                    }
//                } catch {
//                    self.showAlert(error: error, isShowAlert: true)
//                    failure(error)
//                }
//            }
//        }) { error in
//            self.showAlert(error: error, isShowAlert: true)
//            failure(error)
//        }
        request.upload(endPoint, success: { (data) in
            let json = JSON(data)
            print(json)
            guard let result = Mapper<BaseResponse>().map(JSONObject: json.dictionaryObject) else {
                failure(APPError.canNotParseData)
                return
            }
            self.handleResponse(response: result, success: success, failure: failure)
            
        }) { (error) in
            print("APINetwork - upload: \(String(describing: error?.code?.description&))")
            failure(APIError(error: error))
        }
    }
}

// handle base response
extension APINetwork {
    private func handleResponse(response: BaseResponse, success: @escaping NetworkSuccess, failure: @escaping RequestFailure) {
        if response.status == 200 || response.status == nil {
            success(response)
        } else {
            // handle error with message from API
            let error = APIError(baseResponse: response)
            failure(error)
        }
    }
}


