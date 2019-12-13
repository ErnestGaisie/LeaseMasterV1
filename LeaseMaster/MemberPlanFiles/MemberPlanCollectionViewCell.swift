//
//  MemberPlanCollectionViewCell.swift
//  LeaseMaster
//
//  Created by user on 22/10/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit
import Foundation

protocol customRaveDelegate: class {
    func navigateToRave(row: Int)
    //func collapseTableView(row: Int)
}

class MemberPlanCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: customRaveDelegate?
    
    @IBOutlet weak var payPlanLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var firstPoint: UILabel!
    @IBOutlet weak var secondPoint: UILabel!
    @IBOutlet weak var thirdPoint: UILabel!
    
    
    @IBAction func payBut(_ sender: UIButton) {
      delegate?.navigateToRave(row: sender.tag)
    }
    
    
    var plan: MemberPlan!
    {
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI(){
        if let MemberPlan = plan {
            amountLabel.text = MemberPlan.amount
            payPlanLabel.text = MemberPlan.plan
        payButton.setTitle(MemberPlan.buttonText,for: .normal)
            firstPoint.text = MemberPlan.firstPoint
            secondPoint.text = MemberPlan.secondPoint
            thirdPoint.text = MemberPlan.thirdPoint
             setupButtonStyle(button:payButton)
            payButton.layer.borderColor = UIColor.veryLightPink.cgColor
                  payButton.layer.borderWidth = 1.0
            
        }
        
        else{
            amountLabel.text = nil
                       payPlanLabel.text = nil
          
                       firstPoint.text = nil
                       secondPoint.text = nil
                       thirdPoint.text = nil
    }
        
    
}
}
