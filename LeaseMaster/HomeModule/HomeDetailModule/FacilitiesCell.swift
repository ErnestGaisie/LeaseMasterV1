//
//  FacilitiesCell.swift
//  LeaseMaster
//
//  Created by Isaac Annan on 09/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

class FacilitiesCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    var propFacilities: [String] = []
   
    
    @IBOutlet weak var facilitiesCollectionView: UICollectionView!
    @IBOutlet weak var facilitiesDetailButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        facilitiesCollectionView.dataSource = self
        facilitiesCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func addFacilities(items: [String]){
        propFacilities = items
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return propFacilities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "facility", for: indexPath as IndexPath) as! facilityCell
        
        cell.facilityLabel.text = propFacilities[indexPath.row]
        
        return cell
    }
    
    
    

}
