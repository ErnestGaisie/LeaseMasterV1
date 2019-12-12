//
//  savedPropertyTableViewCell.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 10/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

class savedPropertyTableViewCell: UITableViewCell {

    @IBOutlet weak var savedPropertyImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var listCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //savedPropertyImageView.layer.masksToBounds = false
       savedPropertyImageView.layer.cornerRadius = 8.0
        savedPropertyImageView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
