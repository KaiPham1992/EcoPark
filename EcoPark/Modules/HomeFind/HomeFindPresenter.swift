//
//  HomeFindPresenter.swift
//  EnglishApp
//
//  Created Ngoc Duong on 10/26/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import Alamofire
import ObjectMapper

class HomeFindPresenter: HomeFindPresenterProtocol, HomeFindInteractorOutputProtocol {
    
    weak private var view: HomeFindViewProtocol?
    var interactor: HomeFindInteractorInputProtocol?
    private let router: HomeFindWireframeProtocol
    
    init(interface: HomeFindViewProtocol, interactor: HomeFindInteractorInputProtocol?, router: HomeFindWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func searchPlaceByString(text: String) {
        let url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?language=vi_VN&region=vn&key=AIzaSyBRqdB7aPIIdu-OmugGHWnfEncKfdTlaws"
        let params: Parameters = ["input": text]
        //            print(section)
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { response in
            do {
                let json = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String:Any]
                print(json)
                let posts = json["predictions"] as? [[String: Any]] ?? []
                var locations = [GoogleLocationEntity]()
                //print(posts)
                posts.enumerated().forEach({ (index, element) in
                    if let location  = Mapper<GoogleLocationEntity>().map(JSON: element) {
                        locations.append(location)
                    }
                })
                self.view?.didSearch(locations: locations)
                
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func getPlaceDetail(placeId: String) {
        let url = "https://maps.googleapis.com/maps/api/place/details/json?&fields=geometry&key=AIzaSyBRqdB7aPIIdu-OmugGHWnfEncKfdTlaws"
        let params: Parameters = ["place_id": placeId]
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { response in
            do {
                let json = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String:Any]
                print(json)
                if let result = json["result"] as? [String: Any] {
                    if let geometry = result["geometry"] as? [String: Any] {
                        if let location = geometry["location"] as? [String: Any] {
                            if let lat = location["lat"] as? Double, let long = location["lng"] as? Double {
                                self.view?.didGetPlaceDetail(lat: lat, long: long)
                            }
                        }
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
}
