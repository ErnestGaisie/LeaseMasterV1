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
    
    public var savebutton:UIButton = {
       let butt = UIButton()
       butt.backgroundColor  = .gray
       butt.setImage(#imageLiteral(resourceName: "bookmark-border-24-px"), for: .normal)
       butt.translatesAutoresizingMaskIntoConstraints = false
        return butt
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupCarousel()
        
        carouselView.addSubview(savebutton)
        
        savebutton.topAnchor.constraint(equalTo: carouselView.topAnchor, constant: 15.8).isActive = true
        savebutton.trailingAnchor.constraint(equalTo: carouselView.trailingAnchor, constant: -15.8).isActive = true
        savebutton.heightAnchor.constraint(equalToConstant: 18).isActive = true
        savebutton.widthAnchor.constraint(equalToConstant: 10.5).isActive = true
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
