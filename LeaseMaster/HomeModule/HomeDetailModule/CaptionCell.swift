//
//  CaptionCell.swift
//  LeaseMaster
//
//  Created by Isaac Annan on 05/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

class CaptionCell: UITableViewCell {
    
    @IBOutlet weak var propertyName:UILabel!
    @IBOutlet weak var propertyLocation:UILabel!
    @IBOutlet weak var propertyType:UILabel!
    @IBOutlet weak var beds:UILabel!
    @IBOutlet weak var baths:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
