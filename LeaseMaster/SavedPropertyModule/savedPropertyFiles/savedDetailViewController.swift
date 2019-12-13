//
//  savedDetailViewController.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 10/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit
import Kingfisher

class savedDetailViewController: UIViewController {
    
    var properties: [savedProperty] = []

    @IBOutlet weak var propTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //propTableView.reloadData()
        // Do any additional setup after loading the view.
    }

}

extension savedDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = propTableView.dequeueReusableCell(withIdentifier: "groupPropertyCell") as? groupedPropertyTableViewCell
        
        let property = properties[indexPath.row]
        
        cell?.nameLabel.text = property.name
        cell?.priceLabel.text = property.price
        
        KingfisherManager.shared.retrieveImage(with: URL(string: property.imagePath)!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
            cell?.propImageView?.image = image
                                        
                                        })
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340
    }
    
    
}
