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
        
        //print(property)
        self.setupCarousel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCarousel() {
//        print(imagePaths)
//        print(">>>>>>>>>>>>>>>>>>>>>>>>>IMAGES>>>>>>>>>>>>>>>>>>>>>")
//        for i in imagePaths!{
//            Alamofire.request(i).responseImage{ response in
//                if let image = response.result.value {
//                    print("image downloaded: \(image)")
//                }
//            }
//        }
        
        
//        let slide = ZKCarouselSlide(image: #imageLiteral(resourceName: "img1-1"), title: "", description: "")
//        let slide1 = ZKCarouselSlide(image: #imageLiteral(resourceName: "img2-1"), title: "", description: "")
//        let slide2 = ZKCarouselSlide(image: #imageLiteral(resourceName: "img3-1"), title: "", description: "")
//
//        self.carouselView.slides = [slide,slide1,slide2]
        
        self.carouselView.interval = 1.5
    
        self.carouselView.start()

    }
    
}
