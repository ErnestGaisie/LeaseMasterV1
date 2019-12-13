//
//  savedPropertyInteractor.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 10/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

private let _savedPropertyInteractor_SharedInstance = savedPropertyInteractor()



class savedPropertyInteractor{
    
        class var sharedInstance: savedPropertyInteractor
        {
            return _savedPropertyInteractor_SharedInstance
        }
    
    func requestSavedProperties() {
        
        let headers = [
            "Authorization": "Bearer" + "\(Login.shared.accessToken)",
         ]
        
        Alamofire.request(URL(string: "https://leasemaster.qodehub.dev/api/v1/user/saved/properties")!,
                          method: .get,
                          parameters: nil,
                          headers: headers).responseJSON { response in
                   
                   if let data = response.data
                   {
                       do {
                           let json = try JSON(data: data)
                           
                           print(json)
                        let data = json["data"]
                        self.processSavedProperties(json: data)
                       }
                       catch
                       {
                           print("JSON error: \(error)")
                       }
                   }
                   else
                   {
                       print(response.result.error!)
                     //  self.presenter?.processArticlesFailed()
                   }
                   
               }
               print("LOLO")
    }
    
    func processSavedProperties(json: JSON) {
            var properties:[savedProperties] = [savedProperties]()

            for (key, item):(String, JSON) in json
            {
                 var property = savedProperties()
                           
                           let name = item["name"]
                           property.name = name.string!
                           
                           let count = item["properties_count"]
                            property.propertycount = count.int!
                
                           let savingProperties = item["properties"]
                
                var innerProperties: [savedProperty] = []
                
                for (secKey, secItem): (String, JSON) in savingProperties {
                    var prop = savedProperty()
                    
                    let id = secItem["id"].int!
                    prop.id = id
                    
                    let name = secItem["name"].string!
                    prop.name = name
                    
                    let price = secItem["price"].string!
                    prop.price = price
                    
                    let image = secItem["first_image"]
                    let imagePath = image["path"].string!
                    prop.imagePath = imagePath
                    
                    innerProperties += [prop]
                    property.properties = innerProperties
                }
                
                
                           
                           properties += [property]
            }

            
            
            if properties.count > 0
            {
                NotificationCenter.default.post(name: Notification.Name("savedPropertiesReceived"), object:properties)
            }

        }

    }
    
    

