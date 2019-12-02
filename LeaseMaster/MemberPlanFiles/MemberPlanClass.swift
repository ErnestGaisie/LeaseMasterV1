//
//  File.swift
//  LeaseMaster
//
//  Created by user on 23/10/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

class MemberPlan
{
  var amount = ""
    var plan = ""
     var buttonText = ""
    var firstPoint = ""
    var secondPoint = ""
    var thirdPoint = ""
    
    init(amount:String, plan:String, buttonText:String, firstPoint:String, secondPoint:String, thirdPoint:String)
    {
        self.amount = amount
        self.plan = plan
        self.buttonText = buttonText
        self.firstPoint = firstPoint
        self.secondPoint = secondPoint
        self.thirdPoint = thirdPoint
    }
    
    //dummy data
    
    static func fetchPlans() -> [MemberPlan]
    {
        return [
            MemberPlan(amount: "¢35", plan: "Pay As You Go", buttonText: "Pay", firstPoint: "great", secondPoint: "awesome", thirdPoint: "nice!"),
            MemberPlan(amount: "¢135", plan: "Pro",buttonText: "Choose", firstPoint: "ok", secondPoint: "expensive", thirdPoint: "yikes!"),
        ]
    }
  
    
}
