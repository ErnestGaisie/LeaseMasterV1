//
//  SignupModel.swift
//  LeaseMaster
//
//  Created by user on 07/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation
import ObjectMapper


//class UserDetails: Mappable {
//
//    var firstname: String? = ""
//    var lastname: String? = ""
//    var email: String? = ""
//    var updated_at: String? = ""
//    var created_at: String? = ""
//    var id: Int?
//    var fullName: String? = ""
//
//
//    required convenience init?(map: Map) {
//           self.init()
//       }
//
//    func mapping(map: Map) {
//        firstname <- map["firstname"]
//        lastname <- map["lastname"]
//        email <- map["email"]
//        updated_at <- map["updated_at"]
//        id <- map["id"]
//        updated_at <- map["updated_at"]
//        fullName <- map["fullName"]
//       }
//
//}

struct UserDetails: Codable {

    let first_name: String?
    let last_name: String?
    let email: String?
    let updated_at: String?
    let created_at: String?
    let id: Int?
    let fullName: String?


    enum CodingKeys: String, CodingKey {
        case first_name
        case last_name
        case email
        case updated_at
        case created_at
        case id
        case fullName
    }

}

