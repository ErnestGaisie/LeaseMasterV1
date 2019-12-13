//
//  PaymentCell.swift
//  LeaseMaster
//
//  Created by Isaac Annan on 09/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

class PaymentCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    var paymentArray: [String] = [String]()
    
    @IBOutlet weak var paymentCollectionView:UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        paymentCollectionView.delegate = self
        paymentCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addPayment(item: [String]){
        paymentArray = item
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paymentArray.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = paymentCollectionView.dequeueReusableCell(withReuseIdentifier: "payment", for: indexPath as IndexPath) as! payCell
        cell.payTermLabel.text = paymentArray[indexPath.row]
        print("+++++++++++++++++++++++the facilities are here++++++++++++++++++++++")
        print(paymentArray[indexPath.row])
        return cell
      }
    

}
