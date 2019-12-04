//
//  searchPropertyTableViewCell.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 25/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage


class searchPropertyTableViewCell: UITableViewCell {
    
    var property: [String]?
    
    @IBOutlet weak var carouselView: ZKCarousel! = ZKCarousel()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.setupCarousel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCarousel() {
        
        self.carouselView.interval = 0
    
        //self.carouselView.start()

    }
    
}
