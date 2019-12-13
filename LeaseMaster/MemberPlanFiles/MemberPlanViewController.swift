//
//  MemberPlanViewController.swift
//  LeaseMaster
//
//  Created by user on 23/10/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit
import Rave

class MemberPlanViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var plans = MemberPlan.fetchPlans()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
    }
    

    
}


extension MemberPlanViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return plans.count
    }
    
    
    func numberOfSections(in  collectionView:UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberPlanCollectionViewCell", for: indexPath) as! MemberPlanCollectionViewCell
        
        let plan = plans[indexPath.item]
        cell.plan = plan
        cell.payButton.tag = indexPath.row
        cell.delegate = self as? customRaveDelegate
            
            return cell
        
        
    }
    
    
    
}

extension MemberPlanViewController: customRaveDelegate, RavePaymentManagerDelegate {
 
    func ravePaymentManagerDidCancel(_ ravePaymentManager: RavePayManager) {
         print("HAHA")
     }
     
     func ravePaymentManager(_ ravePaymentManager: RavePayManager, didSucceedPaymentWithResult result: [String : AnyObject]) {
         print("HOHO")
     }
     
     func ravePaymentManager(_ ravePaymentManager: RavePayManager, didFailPaymentWithResult result: [String : AnyObject]) {
         print("KIKI")
     }
     
    
    func navigateToRave(row: Int) {
//        let HomeStoryboard: UIStoryboard = UIStoryboard.init(name: "Rave", bundle: nil)
//        let homeScreen = (HomeStoryboard.instantiateViewController(withIdentifier: "raveID") as? raveViewController)!
//        navigationController?.present(homeScreen, animated: true)
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
