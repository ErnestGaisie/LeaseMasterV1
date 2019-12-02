//
//  MemberPlanViewController.swift
//  LeaseMaster
//
//  Created by user on 23/10/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

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
        
        return cell
    }
    
}
