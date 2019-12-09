//
//  FirstPageViewController.swift
//  LeaseMaster
//
//  Created by Isaac Annan on 18/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//
import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import ObjectMapper
import AlamofireImage
//import ZKCarousel
import Kingfisher
import SVProgressHUD


class FirstPageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
    
    var pageCounter: Int = 1
       var currentPage:String?
       var lastPage: String?
       var last: Int = 0
       var propertiesQuantity: String?
    var loadmoreCell: loadMoreCell?
//    var carouselIimages: [ZKCarouselSlide] = [ZKCarouselSlide]()
  
    var properties: [property] = [property]()
    
    @IBOutlet weak var loadMoreData: UIButton!
    
    @IBOutlet weak var allPropertiesTableView: UITableView!
    
    @IBAction func mover(_ sender: UIButton) {
        print("sdfghj")
         let searchStoryboard: UIStoryboard = UIStoryboard.init(name: "Search", bundle: nil)
         let searchPage = (searchStoryboard.instantiateViewController(withIdentifier: "searchNavigationController") as? UINavigationController)!
   
        navigationController?.present(searchPage, animated: true)
    }
    @IBAction func moveToSearchPage(_ sender: UITextField) {
        print("sdfghj")
         let searchStoryboard: UIStoryboard = UIStoryboard.init(name: "Search", bundle: nil)
         let searchPage = (searchStoryboard.instantiateViewController(withIdentifier: "searchNavigationController") as? UINavigationController)!
        navigationController?.pushViewController(searchPage, animated: true)
    }
    @IBOutlet weak var propertySearchTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CircularSpinner.trackPgColor = .LeaseMasterOrange
          CircularSpinner.show()
        loadmoreCell?.loadMoreButton.isHidden = true
      
        allPropertiesTableView.delegate = self
        allPropertiesTableView.dataSource = self
        allPropertiesTableView.separatorStyle = .none
        
        
        
//        allPropertiesTableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        allPropertiesTableView.register(UINib.init(nibName: "PropertiesTableViewCell", bundle: nil), forCellReuseIdentifier: "tCell")

        setupPropertyTextfields(textField: propertySearchTextfield)
//        propertySearchTextfield.addShadowToTextField(color: .gray, cornerRadius: 3, opacity: 0.5)
        
        let viewPadding = UIView(frame: CGRect(x: 0, y: 0, width: 30 , height: Int(propertySearchTextfield.bounds.size.height)))
        propertySearchTextfield.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: -5, y: 14, width: 20, height: 20))
        viewPadding.addSubview(imageView)
        let image = UIImage(named: "search-24-px")
        image?.withTintColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        imageView.image = image
        propertySearchTextfield.rightView = viewPadding
     
        
        NotificationCenter.default.addObserver(self, selector: #selector(onPropertiesRecieved(notification:)), name: Notification.Name("Properties Recieved"), object: nil)
        
         makeRequest(page: pageCounter)

}
         
    
    
    @objc func onPropertiesRecieved(notification: Notification) {
        if let properties: [property] = notification.object as? [property]{
            self.properties = properties
            self.allPropertiesTableView.reloadData()
           CircularSpinner.hide()
            
        }
    }
     


    
    func processProperties(json: JSON) {
        var properties: [property] = [property]()
        
        for (key, item): (String, JSON) in json {
            var prop = property()
            
            let name = item["name"]
            prop.name = name.string!
            
            let price = item["price"]
            prop.price = price.string!
            
            let arrayImages = item["images"]
            
            let arrayFacilities = item["facilities"]
            
            let arrayPayment = item["payment_terms"]
            
            let description = item["description"]
            prop.description = description.string!
            
            let city = item["city"]
            prop.cityName = city["name"].string!
            prop.regionName = city["region"]["name"].string!
            
            let meta = item["meta"]
            prop.occupants = meta["occupants"].int!
            prop.bathrooms = meta["bathroom"].int!
            prop.bedrooms = meta["bedroom"].int!
            
            let propertyTypeName = item["type"]
            prop.typeName = propertyTypeName["name"].string!
            
            let currency = item["currency"]
            prop.currencyShortname = currency["short_name"].string!
            
            var facility: [String] = []
            for (key, item): (String, JSON) in arrayFacilities {
                let propertyFacilities =  facilities()
                
                let name = item["name"].string!
                propertyFacilities.name = name
                
                facility += [propertyFacilities.name]
                prop.facilities = facility
            }
            
            var payment: [String] = []
            for (key, item): (String, JSON) in arrayPayment{
                let propertyPayment = paymentTerms()
                
                let name = item["name"].string!
                propertyPayment.name = name
                
                payment += [propertyPayment.name]
                prop.payment = payment
            }
            
            
            var propertyPaths: [String] = []
            
            for (innerKey, innerItem): (String, JSON) in arrayImages {
                var propertyImages = images()
                
                let path = innerItem["path"].string!
                propertyImages.path = path
                
                propertyPaths += [propertyImages.path]
                prop.paths = propertyPaths
            }
            
            properties += [prop]
        }
        
        if properties.count > 0 {
            NotificationCenter.default.post(name: Notification.Name("Properties Recieved"), object: properties)
        }
}
        
    
    
        


              func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return properties.count + 2
              }
            
            
              
              func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                  if indexPath.row == 0 {
                      
                  let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
                     return cell
                  }
                    else
                    if(indexPath.row == properties.count + 1) {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "bottomCell", for: indexPath) as! loadMoreCell

                        cell.loadMoreButton.addTarget(self, action: #selector(loadMore), for: .touchUpInside)
                        return cell
                    }
                  else
                  {
                    
                let cell = tableView.dequeueReusableCell(withIdentifier: "tCell", for: indexPath) as! PropertiesTableViewCell
                    
                    
                    
                    let mProperties = properties[indexPath.row-1]
                    
                    cell.propertyTypeLabel.text = "\(mProperties.typeName.uppercased()) . \(mProperties.bedrooms) BEDS . \(mProperties.bathrooms) BATHS"
                    cell.propertyNameLabel.text = mProperties.name
                    cell.priceLabel.text = "\(mProperties.currencyShortname) \(mProperties.price) / month"
                      
                    var images: [ZKCarouselSlide] = [ZKCarouselSlide]()
                   
                    for item in mProperties.paths{
                        

                        KingfisherManager.shared.retrieveImage(with: URL(string: item)!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                           
                            let slide = ZKCarouselSlide(image: image!, title: "", description: "")
                            
                            images += [slide]
                            cell.carousel.slides = images
                        
                        })
        
                    }
    
                    return cell
                   }
                
                
    
    }
    
  
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
          if indexPath.row == 0 {
            return nil
        }
            else
            if indexPath.row == properties.count + 1 {
                return nil
            }
        
          else{
            return indexPath
        }
                  
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mc = (storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailsOfPropertiesTableViewController)!
//          let vc = (storyboard?.instantiateViewController(withIdentifier: "detailView") as? propertiesDetailViewController)!
//
        let detailedProperty = properties[indexPath.row - 1]
        let detailedPropertyName = properties[indexPath.row - 1].name
        let detailedPropertyCity = properties[indexPath.row - 1].cityName
        let detailedPropertyRegion = properties[indexPath.row - 1].regionName
        let detailedPropertyType = properties[indexPath.row - 1].typeName
        let detailedBedrooms = properties[indexPath.row - 1].bedrooms
        let detailedBathrooms = properties[indexPath.row - 1].bathrooms
        let detailedPropertyDescription = properties[indexPath.row - 1].description
        
       // let detailedFacilityName = propert
//        let detailedDescription = properties[indexPath.row - 1].description
//        let detailedCity = properties[indexPath.row - 1].cityName
//        let detailedRegion = properties[indexPath.row - 1].regionName
//        let detailedPropertyType = properties[indexPath.row - 1].typeName
//        let detailedBedrooms = properties[indexPath.row - 1].bedrooms
//        let detailedBathrooms = properties[indexPath.row - 1].bathrooms
//        let detailedOccupants = properties[indexPath.row - 1].occupants
//        let detailedPrice = properties[indexPath.row - 1].price
//        let detailedCurrShortname = properties[indexPath.row - 1].currencyShortname
//
//
//
//        vc.getDetailedProperty = detailedProperty
//        vc.getDetailedPropertyName = detailedPropertyName
//        vc.getDetailedDescription = detailedDescription
//        vc.getDetailedRegion = detailedRegion
//        vc.getDetailedCity = detailedCity
//        vc.getDetailedPropertyType = detailedPropertyType
//        vc.getDetailedBedrooms = detailedBedrooms
//        vc.getDetailedBathrooms = detailedBathrooms
//        vc.getDetailedOccupants = detailedOccupants
//        vc.getDetailedCurrencyShortname = detailedCurrShortname
//        vc.getDetailedPrice = detailedPrice
//
//
//        vc?.imageSlider.slides = properties[indexPath.row]
        mc.getProperties = detailedProperty
        
        mc.getDetailedPropertyName = detailedPropertyName
        mc.getPropertyCity = detailedPropertyCity
        mc.getPropertyRegion = detailedPropertyRegion
        mc.getPropertyType = detailedPropertyType
        mc.getDetailedBedrooms = detailedBedrooms
        mc.getPropertyBathrooms = detailedBathrooms
        mc.getDetailedDescription = detailedPropertyDescription
        
        navigationController?.pushViewController(mc, animated: true)
        mc.navigationController?.navigationBar.backgroundColor = .white
       

//        self.present(vc!, animated: true, completion: nil)
    }
    
    
    
//      func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//            //properties += properties
////            if indexPath.row == properties.count - 1 {
////
////                if currentPage == lastPage {
////
////                    print("last page")
////                }
////
////                else{
////                    pageCounter += 1
////                    makeRequest(page: pageCounter)
////                }
////            }
//        }
//
    
    @objc func loadMore(){
        if currentPage == lastPage {
            print("last page reached")
        }
        
        else{
            pageCounter += 1
            makeRequest(page: pageCounter)
        }
        
    }
    
     func makeRequest(page: Int) {
               Alamofire.request("\(APIConstants.Properties_JSON_URL)?page=\(page)").responseJSON { response in
                   CircularSpinner.hide()
                   //print(response)
                //self.loadmoreCell?.loadMoreButton.isHidden = false
                   self.last = self.properties.count
                   self.allPropertiesTableView.reloadData()
                         
                   if let data = response.data{
                       
                       do {
                           let json = try JSON(data: data)
                           
                           let innerData = json["data"]
                           
                           if innerData["total"].stringValue == "0"{
                               self.allPropertiesTableView.isHidden = true
                           }
                           else{
                           
                           self.propertiesQuantity = innerData["total"].stringValue
                           self.currentPage = innerData["current_page"].stringValue
                           self.lastPage = innerData["last_page"].stringValue
                           
                           if self.currentPage == self.lastPage {
                               print("last page reached")
                       }
               }
                         
                           
                           
                           let anotherData = innerData["data"]
                           
                           self.processProperties(json: anotherData)
                           
                          
                       }
                       catch{
                           CircularSpinner.hide()
                           print("JSON error: \(error)")
                           let alert = UIAlertController(title: "Poor Internet Connection", message: "\(error)", preferredStyle: .alert)
                           alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel)
                           {
                               UIAlertAction in
                               alert.dismiss(animated: true, completion: nil)
                           })
                           
                           self.present(alert,animated: true, completion: nil)
                       }
                   }
              
           }

       }

    
    
    
                       

}
        


