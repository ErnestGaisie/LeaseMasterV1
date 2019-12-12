//
//  savedPropertyViewController.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 10/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit
import Kingfisher

class savedPropertyViewController: UIViewController{
    
    var properties: [savedProperties] = [savedProperties]()
    
        
    @IBOutlet weak var savedPropertyTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        savedPropertyPresenter.sharedInstance.updateView()
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.onPropertiesReceived(notification:)), name: Notification.Name("savedPropertiesReceived"), object: nil)
    }
    
    @objc func onPropertiesReceived(notification: Notification)
       {
           if let properties: [savedProperties] = notification.object as? [savedProperties]
           {
               self.properties = properties
               self.savedPropertyTableView.reloadData()
                   
           }
       }
    
}

extension savedPropertyViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell") as! savedPropertyTableViewCell
        let propertyList = properties[indexPath.row]
        
        cell.nameLabel.text = propertyList.name
        cell.listCountLabel.text = "\(propertyList.propertycount) properties saved"
        
        print(propertyList.properties)
        
        
        return cell
    }


}
