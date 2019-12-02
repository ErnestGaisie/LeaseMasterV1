//
//  property.swift
//  LeaseMaster
//
//  Created by Isaac Annan on 26/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation
import UIKit

class property {
    var name: String = ""
    var price: String = ""
    var paths: [String] = []
    var occupants: Int = 0
    var bedrooms: Int = 0
    var bathrooms: Int = 0
    var description: String = ""
    var cityName: String = ""
    var regionName: String = ""
    var typeName: String = ""
    var currencyName: String = ""
    var currencyShortname: String = ""
    
    
}


class images {
    var propertyId: Int = 0
    var publicId: String = ""
    var url: String = ""
    var description: String = ""
    var path: String = ""
    
}

class paymentTerms {
    var id: Int = 0
    var icon: UIImage?
    var name: String = ""
    var description: String = ""
    
}

class facilities {
    var id: Int = 0
    var name: String = ""
}


//class metaDetails{
//    var occupants:Int =
//
//}
