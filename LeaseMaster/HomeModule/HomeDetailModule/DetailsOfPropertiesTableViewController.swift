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
    var getPropertyPrice:String?
    var getPropertyCurrency:String?
    
    
    
    
    
    var getPropertyFacilityName: String?
    
    
    let requestContactButton: UIButton = {
          let rButton = UIButton()
          rButton.setTitle("Request Contact", for: .normal)
          rButton.titleLabel?.font = UIFont(name: "Gilroy-Bold", size: 15)
          rButton.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.4549019608, blue: 0.1294117647, alpha: 1)
        
        rButton.addTarget(self, action: #selector(actOnClick), for: .touchUpInside)
          return rButton
      }()
    
    @objc func actOnClick() {
        print("Enam's new hair style")
    }
    
    let priceLabel: UILabel = {
        let pLabel = UILabel()
        pLabel.font = UIFont(name: "Gilroy-Bold", size: 20)
        pLabel.text = "¢1500"
        //pLabel.backgroundColor = .white
        
        return pLabel
    }()
     
    let monthLabel: UILabel = {
           let pLabel = UILabel()
           pLabel.font = UIFont(name: "Gilroy-Regular", size: 13)
           pLabel.text = " / month"
           //pLabel.backgroundColor = .white
           
           return pLabel
       }()
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
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
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let customView = UIView()
       
        
        customView.addSubview(priceLabel)
        customView.addSubview(monthLabel)
        customView.addSubview(requestContactButton)
        
        priceLabel.anchor(top: customView.topAnchor, left: customView.leftAnchor, paddingTop: 30, paddingLeft: 15, height: 20)
        priceLabel.minimumScaleFactor = 0.5
        
        monthLabel.anchor(top: customView.topAnchor, left: priceLabel.rightAnchor, right: requestContactButton.leftAnchor, paddingTop: 30, paddingLeft: 0, paddingRight: 0, height: 20, width: 60)
        
        requestContactButton.anchor(top: customView.topAnchor, right: customView.rightAnchor, paddingTop: 16, paddingRight: 15, height: 48, width: 180)
        
        customView.backgroundColor = UIColor.white
        customView.layer.shadowOpacity = 0.05
        customView.layer.shadowRadius = 1
        priceLabel.text = "\(getPropertyCurrency!)\(getPropertyPrice!)"
        return customView
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 110
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

            
    if UserDefaults.standard.bool(forKey: "USERLOGGEDIN") == false {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! LoginCell
            cell.loginButton.tag = indexPath.row
            cell.loginButton?.addTarget(self, action: #selector(self.login(sender:)), for: .touchUpInside)
           
            return cell
            }
            
    else {
                
        if UserDefaults.standard.bool(forKey: "USERMADEPAYMENT") == false {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell8", for: indexPath)
        return cell
                }
                
                else {
                    
     let cell = tableView.dequeueReusableCell(withIdentifier: "cell7", for: indexPath) as! OwnerDetailsCell
    cell.contactOwnerButton.tag = indexPath.row
    cell.contactOwnerButton?.addTarget(self, action: #selector(self.contactOwner(sender:)), for: .touchUpInside)
    return cell
                    
                }
   
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
            
            cell.facilitiesDetailButton.addTarget(self, action: #selector(moveToDetailPage), for: .touchUpInside)
            
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
    
    @objc func moveToDetailPage(){
        let fVC = (storyboard?.instantiateViewController(withIdentifier: "facilitiesDetail") as? FacilitiesDetailViewController)!
        
        for facility in getProperties!.facilities {
            self.pFacilities += [facility]
            
            
        }
        fVC.facilitiesArray = pFacilities
        
        navigationController?.pushViewController(fVC, animated: true)
        
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
