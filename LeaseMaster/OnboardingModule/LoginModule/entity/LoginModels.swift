//
//  LoginModels.swift
//  LeaseMaster
//
//  Created by user on 18/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation



struct LoginDetails: Codable {

    let id: Int?
    let type: String?
    let first_name: String?
    let last_name: String?
    let email: String?
    let email_verified_at: String?
    let default_phone: String?
    let avatar_public_id: String?
    let avatar : String?
    let fullName: String?
    let avatarPath:String?


    enum CodingKeys: String, CodingKey {
         case id
        case type
        case first_name
        case last_name
        case email
        case email_verified_at
        case default_phone
        case avatar_public_id
        case avatar
        case fullName
        case avatarPath
    }

}
