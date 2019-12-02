//
//  Constants.swift
//  LeaseMaster
//
//  Created by user on 07/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation
import UIKit

class Constants{
    
    public static let URL = "https://leasemaster.qodehub.dev/api/v1/user/register"
    public static let loginURL = "https://leasemaster.qodehub.dev/api/v1/user/login"
    public static let NEWS_API_KEY = "17cf1b333e964cea91e89e1e824bd366"
     public static let passwordResetURL = "https://leasemaster.qodehub.dev/api/v1/user/password/forget"
}

extension NSAttributedString{
    static func makeHyperLink(for path:String, in String: String, as substring: String) -> NSAttributedString
    {
        let nsString = NSString(string: String)
        let substringRange = nsString.range(of: substring)
        let attributedString = NSMutableAttributedString(string: String)
        attributedString.addAttribute(.link, value: path, range: substringRange)
        
        return attributedString
        
    }
}


extension UIColor {
class var leaseMasterRed: UIColor {
       return UIColor(red: 255.0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 1.0)
   }
}


