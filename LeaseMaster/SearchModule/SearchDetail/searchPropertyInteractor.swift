//
//  popertyInteractor.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 25/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private let _searchPropertyInteractor_Shared_Instance  = searchPropertyInteractor()


class searchPropertyInteractor {
    class var sharedInstance: searchPropertyInteractor
       {
           return _searchPropertyInteractor_Shared_Instance
       }
    
    func fetchProperties(location: String) -> Void {
           Alamofire.request(URL(string: "https://leasemaster.qodehub.dev/api/v1/user/filter?location=\(location)")!).responseJSON { response in
               
               if let data = response.data
               {
                   do {
                       let json = try JSON(data: data)
                        
                       let secData = json["data"]
                    
                    self.processSearchProperties(json: secData)
                   }
                   catch {
                       print("JSON error: \(error)")
                   }
               }
               
           }
       }
    
    func processSearchProperties(json: JSON) {
        
        //print(json)
        var properties: [searchedProperty] = [searchedProperty]()
        
        for (key, item): (String, JSON) in json {
            var property = searchedProperty()
            
            let name = item["name"]
            property.name = name.string!
            
            let price = item["price"]
            property.price = price.string!
            
            let arrImages = item["images"]
            
        
            //var propertyImages: [images] = [images]()
            var propertyPaths: [String] = []
            //print(images)
            for (secKey, secItem): (String,JSON) in arrImages {
                var propImage = imagesSearch()
                //var propertyPath = String()
                let path = secItem["path"].string!
                propImage.path = path
                //property.images += [propImage]
                
                propertyPaths += [propImage.path]
                property.paths = propertyPaths
                
                
               // print(property.paths)
            }
            
            properties += [property]
    }
        
        if properties.count > 0
        {
            NotificationCenter.default.post(name: Notification.Name("searchedPropertiesReceived"), object:properties)
        }
}

}

