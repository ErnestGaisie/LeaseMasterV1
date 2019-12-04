//
//  labelTableViewCell.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 03/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit
import SkeletonView


class labelTableViewCell: UITableViewCell {

    @IBOutlet weak var labelText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
