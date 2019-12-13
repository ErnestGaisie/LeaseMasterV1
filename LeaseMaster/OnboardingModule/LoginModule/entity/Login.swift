//
//  Login.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 09/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation

class Login {
    
    static let shared: Login = Login()
    
    var fullName: String = ""
    var avatarPath: String?
    var default_phone: String = ""
    var email: String = ""
    var accessToken: String = ""
}
