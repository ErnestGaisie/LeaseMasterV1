//
//  PropertiesTableViewCell.swift
//  LeaseMaster
//
//  Created by Isaac Annan on 22/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit


class PropertiesTableViewCell: UITableViewCell {
    var images : [String] = [String]()
    @IBOutlet var carousel: ZKCarousel! = ZKCarousel()
    
    @IBOutlet weak var propertyTypeLabel: UILabel!
    
    @IBOutlet weak var propertyNameLabel: UILabel!
    
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
//        setupCarousel()
        
//        carousel.addSubview(savebutton)
//    
//        savebutton.topAnchor.constraint(equalTo: carousel.topAnchor, constant: 15.8).isActive = true
//             savebutton.trailingAnchor.constraint(equalTo: carousel.trailingAnchor, constant: -15.8).isActive = true
//             savebutton.heightAnchor.constraint(equalToConstant: 18).isActive = true
//             savebutton.widthAnchor.constraint(equalToConstant: 10.5).isActive = true
    }
    
    func setupCarousel(){
        self.carousel.interval = 3
        self.carousel.start()
        }
        
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
