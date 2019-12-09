//
//  loadMoreCell.swift
//  LeaseMaster
//
//  Created by Isaac Annan on 04/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

class loadMoreCell: UITableViewCell {
    
    @IBOutlet weak var loadMoreButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loadMoreButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
