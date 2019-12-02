//
//  LoginResponse.swift
//  LeaseMaster
//
//  Created by user on 18/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation


struct LoginResponse: Codable {
    let status: Int?
    let success: Bool?
    let message: String?
    let data: LoginDetails?
    let token_type: String?
    let expires_in: Int?
    let access_token: String?
    
    enum CodingKeys: String, CodingKey {
        case status
        case success
        case message
        case data
        case token_type
        case expires_in
        case access_token
        
        
    }
}
