//
//  RegistrationResponse.swift
//  LeaseMaster
//
//  Created by user on 07/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation
//import ObjectMapper

//class RegistrationResponse: Mappable {
//
//
//
//
//    var status: String? = ""
//    var success: String? = ""
//    var message: String? = ""
//    var user: [UserDetails]?
//
//     required convenience init?(map: Map) {
//           self.init()
//       }
//
//    func mapping(map: Map) {
//           status <- map["status"]
//            success <- map["success"]
//           message <- map["message"]
//            user <- map["user"]
//
//       }
//}

struct RegistrationResponse: Codable {
    let status: Int?
    let success: Bool?
    let message: String?
    let user: UserDetails?
    
    enum CodingKeys: String, CodingKey {
        case status
        case success
        case message
        case user
    }
}
