//
//  DetailsOfPropertiesTableViewController.swift
//  LeaseMaster
//
//  Created by Isaac Annan on 05/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsOfPropertiesTableViewController: UITableViewController {

    var images: [ZKCarouselSlide] = [ZKCarouselSlide]()
    var pFacilities: [String] = [String]()
    var pPayment: [String] = [String]()
    
    var expandedCell: Int?
    var anotherExpand: Int?
    
    var getProperties: property?
    
    var getDetailedPropertyName: String?
    var getDetailedDescription: String?
    var getDetailedOccupants: Int?
    var getDetailedBedrooms: Int?
    var getPropertyBathrooms:Int?
    var getPropertyRegion:String?
    var getPropertyCity:String?
    var getPropertyType:String?
    
    
    
    
    
    var getPropertyFacilityName: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    @objc func login(sender: UIButton){
        expandedCell = sender.tag
        images = []
        tableView.reloadData()
        
    }
    
    @objc func contactOwner(sender: UIButton){
        expandedCell = sender.tag
        anotherExpand = expandedCell
        images = []
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CarouselCell
            images = []
            for imgPath in getProperties!.paths{
                
                KingfisherManager.shared.retrieveImage(with: URL(string: imgPath)!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                        let slide = ZKCarouselSlide(image: image!, title: "", description: "")
                                
                    self.images += [slide]
                    cell.imageSlider.slides = self.images
                              
                    })
                
            }
            
            return cell
        }
       
        else if indexPath.row == 1{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CaptionCell
            cell.propertyName.text = getDetailedPropertyName
            cell.propertyLocation.text = "\(String(describing:getPropertyCity!)), \(String(describing:getPropertyRegion!))"
            cell.propertyType.text = getPropertyType
            cell.beds.text = "\(String(describing: getDetailedBedrooms!))"
            cell.baths.text = "\(String(describing: getPropertyBathrooms!))"
            return cell
        }
            else if indexPath.row == anotherExpand{
                           
                        let cell = tableView.dequeueReusableCell(withIdentifier: "cell8", for: indexPath)
                           return cell
                       }
            
        else if indexPath.row == 2{
            if indexPath.row == expandedCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell7", for: indexPath) as! OwnerDetailsCell
                cell.contactOwnerButton.tag = indexPath.row
                cell.contactOwnerButton?.addTarget(self, action: #selector(self.contactOwner(sender:)), for: .touchUpInside)
                return cell
            }
           
                
            else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! LoginCell
            cell.loginButton.tag = indexPath.row
            cell.loginButton?.addTarget(self, action: #selector(self.login(sender:)), for: .touchUpInside)
           
            return cell
            }
        }
        else if indexPath.row == 3{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath) as! DescriptionCell
            cell.descriptionField.text = getDetailedDescription
            
            return cell
        }
        else if indexPath.row == 4{

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell5", for: indexPath) as! FacilitiesCell
            for facility in getProperties!.facilities {
                self.pFacilities += [facility]
                
                cell.addFacilities(items: pFacilities)
            }
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell6", for: indexPath) as! PaymentCell
            for pay in getProperties!.payment {
                self.pPayment += [pay]
                print("***************just showing the payment*****************")
                print(pPayment)
                
                cell.addPayment(item: pPayment)
            }
            
            return cell
        }
        
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
