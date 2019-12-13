//
//  saveToListViewController.swift
//  LeaseMaster
//
//  Created by Isaac Annan on 10/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

class saveToListViewController: UIViewController {

    @IBOutlet weak var bottomView:saveBottomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bottomView.propertyImage.image = #imageLiteral(resourceName: "img2-1")
        
        bottomView.propertyName.text = "Beautiful house in East Legon"
        bottomView.propertyName.backgroundColor = .clear
        bottomView.propertyLocation.text = "East Legon, Greater Accra"
        bottomView.propertyLocation.backgroundColor = .clear
        
    }
    

   

}
