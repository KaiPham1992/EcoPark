//
//  AppDelegate+GoogleSignIn.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

//import GoogleSignIn
import GoogleMaps
import GooglePlaces
import Firebase

extension AppDelegate {
    
    
    
    func configureGoogle() {
        #if PROD
        GMSServices.provideAPIKey("AIzaSyBagkVuIHgxWBeASzVpzimH0GoiqoIenNw")
        GMSPlacesClient.provideAPIKey("AIzaSyBagkVuIHgxWBeASzVpzimH0GoiqoIenNw")
//        GIDSignIn.sharedInstance().clientID = "925930271420-g38602u84281v4htrbc2um3o7i70jbi8.apps.googleusercontent.com"
        #else
        GMSServices.provideAPIKey("AIzaSyBagkVuIHgxWBeASzVpzimH0GoiqoIenNw")
        GMSPlacesClient.provideAPIKey("AIzaSyBagkVuIHgxWBeASzVpzimH0GoiqoIenNw")
//        GIDSignIn.sharedInstance().clientID = "925930271420-g38602u84281v4htrbc2um3o7i70jbi8.apps.googleusercontent.com"
        #endif
        configureFirebase()
    }
    
    func setUpStatusBar() {
        guard #available(iOS 13.0, *) else {
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
            //            guard let _ = UIApplication.shared.value(forKey: "statusBar") as? UIView else { return }
            return
        }
    }
}
