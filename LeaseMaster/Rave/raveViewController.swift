//
//  raveViewController.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 12/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit
import Rave

class raveViewController: UIViewController , RavePaymentManagerDelegate{

   func ravePaymentManagerDidCancel(_ ravePaymentManager: RavePayManager) {
        print("HAHA")
    }
    
    func ravePaymentManager(_ ravePaymentManager: RavePayManager, didSucceedPaymentWithResult result: [String : AnyObject]) {
        print("HOHO")
    }
    
    func ravePaymentManager(_ ravePaymentManager: RavePayManager, didFailPaymentWithResult result: [String : AnyObject]) {
        print("KIKI")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
     //showRaveView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showRaveView()
    }
    
    func showRaveView(){
        let raveMgr = RavePayManager()
        raveMgr.email = "ernestyawgaisie@gmail.com" //Customer's email address
        raveMgr.amount = "25" // Amount
        raveMgr.transcationRef = "Unique-Transaction-ref" //Unique transaction reference
        raveMgr.currencyCode = "GHS"
        raveMgr.delegate = self
        raveMgr.narration = "narration"
        //raveMrg.supportedPaymentMethods = [.card,.account] // Choose supported payment channel allowed
        //Set your recurring payment ID, Only set this if you are enabling recurring payments
        //raveMgr.paymentPlan = <PAYMENT PLAN ID>

        raveMgr.show(withController:self)
    }

}
