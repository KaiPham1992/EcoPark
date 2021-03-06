//
//  AppDelegate+GoogleSignIn.swift
//  Oganban
//
//  Created by Kai Pham on 12/21/18.
//  Copyright © 2018 Coby. All rights reserved.
//

import GoogleSignIn
//import GoogleMobileAds
import Firebase

extension AppDelegate {
    func configureGoogle() {
//        GADMobileAds.configure(withApplicationID: AppConstant.appAdmobId)
        
        // get key from fire base : AIzaSyCaOVKfotVN6tQ4sUbv8ssND
        #if PROD
//        GMSServices.provideAPIKey("AIzaSyAwDru9BQm6Vj7DeyCSfqZgAJc3V748aug")
//        GMSPlacesClient.provideAPIKey("AIzaSyAwDru9BQm6Vj7DeyCSfqZgAJc3V748aug")
        GIDSignIn.sharedInstance().clientID = "925930271420-g38602u84281v4htrbc2um3o7i70jbi8.apps.googleusercontent.com"
        #else
//        GMSServices.provideAPIKey("AIzaSyBcHRsiNktggnuR-I5eeuZTfRemWD5Dr4c")
//        GMSPlacesClient.provideAPIKey("AIzaSyBcHRsiNktggnuR-I5eeuZTfRemWD5Dr4c")
        GIDSignIn.sharedInstance().clientID = "925930271420-g38602u84281v4htrbc2um3o7i70jbi8.apps.googleusercontent.com"
//        GIDSignIn.sharedInstance().clientID = "925930271420-bhbihfqrd3lamp7e6g5ndce2eaaoae2d.apps.googleusercontent.com"
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
