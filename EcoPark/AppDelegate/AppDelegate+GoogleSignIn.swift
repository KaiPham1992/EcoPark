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

#if PROD
    let googleApiKey = "AIzaSyBAyFmdfB3RdIWjocHRQnYOE0Bv0BxaXaA"
#else
    let googleApiKey = "AIzaSyBAyFmdfB3RdIWjocHRQnYOE0Bv0BxaXaA"
#endif

extension AppDelegate {
    
    func configureGoogle() {
        #if PROD
        GMSServices.provideAPIKey(googleApiKey)
        GMSPlacesClient.provideAPIKey(googleApiKey)
        #else
        GMSServices.provideAPIKey(googleApiKey)
        GMSPlacesClient.provideAPIKey(googleApiKey)
        #endif

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
