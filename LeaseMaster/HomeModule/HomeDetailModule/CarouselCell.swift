//
//  CarouselCell.swift
//  LeaseMaster
//
//  Created by Isaac Annan on 05/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

class CarouselCell: UITableViewCell {

    @IBOutlet weak var imageSlider: ZKCarousel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
