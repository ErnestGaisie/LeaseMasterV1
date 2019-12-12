//
//  FacilitiesDetailViewController.swift
//  LeaseMaster
//
//  Created by Isaac Annan on 12/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

class FacilitiesDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var facilitiesArray:[String] = [String]()
    
    @IBOutlet weak var facilitiesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        facilitiesTableView.delegate = self
        facilitiesTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facilitiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "facilitiesDetail", for: indexPath) as! FacilityDetailCell
        
        cell.facilityName.text = facilitiesArray[indexPath.row]
        
        return cell
    }
    

}
