//
//  UserDefaultHelper.swift
//  DQHome-Dev
//
//  Created by Ngoc Duong on 10/19/18.
//  Copyright © 2018 Engma. All rights reserved.
//

import Foundation
import ObjectMapper
import GoogleMaps
import GooglePlaces


class LiveData {
    public static var listDownloading : [Int] = []
}


enum UserDefaultHelperKey: String {
    case deviceToken = "DeviceToken"
    case fcmToken = "FcmToken"
    case userToken = "UserToken"
    case appLanguage = "appLanguage"
    
    
    case userName  = "UserName"
    case email = "Email"
    case bio = "Bio"
    case website = "Website"
    case profilePhoto = "Profile Photo"
    case refreshToken = "RefreshUserToken"
    
    case userLoggedIn = "UserLogin"
    case userSkipIntro = "UserSkipIntroduction"
    case isFirstLauch = "IsFirstLauch"
    case loginUserInfo = "loginUserInfo"
    case parkingID = "ParkingID"
    case birthday = "birthday"
    case numberHours = "numberHours"
    case plate = "plate"
}

class UserDefaultHelper {
    static let shared = UserDefaultHelper()
    private let userDefaultManager = UserDefaults.standard
    //    var collectionProduct = ProductCollectionEntity()
    
    var myLocationCoordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 10.7981483, longitude: 106.6715733)
    
    var loginUserInfo: UserEntity? {
        get {
            if let savedUser = UserDefaults.standard.object(forKey: UserDefaultHelperKey.loginUserInfo.rawValue) as? String {
                let user = Mapper<UserEntity>().map(JSONString: savedUser)
                return user
            }
            return nil
        }
        set(loginUserInfo) {
            guard let json = loginUserInfo?.toJSONString() else { return }
            
            UserDefaults.standard.set(json, forKey: UserDefaultHelperKey.loginUserInfo.rawValue)
        }
    }
    
    
    var fcmToken: String? {
        get {
            let value = get(key: .fcmToken) as? String
            return value
        }
        set(newToken) {
            save(value: newToken, key: .fcmToken)
        }
    }
    
    var deviceToken: String? {
        get {
            let value = get(key: .deviceToken) as? String
            return value
        }
        set(newToken) {
            save(value: newToken, key: .deviceToken)
        }
    }
    
    var userToken: String? {
        get {
            let value = get(key: .userToken) as? String
            return value
        }
        set(newToken) {
            save(value: newToken, key: .userToken)
        }
    }
    
    var appLanguage: String? {
        get {
            let value = get(key: .appLanguage) as? String
            return value
        }
        set(newToken) {
            save(value: newToken, key: .appLanguage)
        }
    }
    
    var isLogedIn: Bool {
        return !userToken&.isEmpty
    }
    
    var parkingID: String {
        get {
            guard let _parkingID = get(key: .parkingID) as? String else { return "" }
            return _parkingID
        }
        set(newValue) {
            save(value: newValue, key: .parkingID)
        }
    }
    
    var birthday: Date? {
        get {
            guard let _birthday = get(key: .birthday) as? Date else { return nil }
            return _birthday
        }
        set(newValue) {
            save(value: newValue, key: .birthday)
        }
    }
    
    var numberHours: String {
        get {
            guard let _numberHours = get(key: .numberHours) as? String else { return "" }
            return _numberHours
        }
        
        set(value) {
            save(value: value, key: .numberHours)
        }
    }
    
    var plate: String {
        get {
            guard let _plate = get(key: .plate) as? String else { return "" }
            return _plate
        }
        set(newValue) {
            save(value: newValue, key: .plate)
        }
    }
}

extension UserDefaultHelper {
    private func save(value: Any?, key: UserDefaultHelperKey) {
        userDefaultManager.set(value, forKey: key.rawValue)
        userDefaultManager.synchronize()
    }
    
    private func get(key: UserDefaultHelperKey) -> Any? {
        return userDefaultManager.object(forKey: key.rawValue)
    }
    
    func clearUser() {
        UserDefaults.standard.removeObject(forKey: UserDefaultHelperKey.userToken.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultHelperKey.loginUserInfo.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultHelperKey.birthday.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultHelperKey.parkingID.rawValue)
    }
    
    func saveUser(user: UserEntity) {
        loginUserInfo = user
    }
    
}
