//
//  SearchInteractor.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 18/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private let _SearchInteractor_Shared_Instance  = SearchInteractor()

class SearchInteractor {
    class var sharedInstance: SearchInteractor
       {
           return _SearchInteractor_Shared_Instance
       }
    
    func requestLocations() -> Void {
        Alamofire.request(URL(string: "https://leasemaster.qodehub.dev/api/v1/user/locations")!).responseJSON { response in
            
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    let secData = json["data"]
                    
                    self.processLocations(json: secData)
                   
                }
                catch
                {
                    print("JSON error \(error)")
                }
            }
            
        }
    }
    
    func processLocations(json:JSON) {
        
        var locations: [Location] = [Location]()
        
        for (key, item): (String, JSON) in json {
            
            
            let cities = item["cities"]
            
           // var locationsArray: [Location] = []
            
            for (secKey, secItem): (String, JSON) in cities {
                var location = Location()
                
                location.name = secItem["name"].string!
                location.slug = secItem["slug"].string!
                
                locations += [location]
            }
           // print(locations)
            //locations += [location]
            
        }
        
        if locations.count > 0 {
            NotificationCenter.default.post(name: Notification.Name("locationsReceived"), object: locations)
        }
        
    }
    
    
    
}
