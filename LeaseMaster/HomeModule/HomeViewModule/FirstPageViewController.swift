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


class FirstPageViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
  
//    var carouselIimages: [ZKCarouselSlide] = [ZKCarouselSlide]()
  
    var properties: [property] = [property]()
    
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
        
                Alamofire.request(APIConstants.Properties_JSON_URL).responseJSON { response in
                    
                    //print(response)
                    if let data = response.data{
                        
                        do {
                            let json = try JSON(data: data)
                            
                            let innerData = json["data"]
                            
                            let anotherData = innerData["data"]
                            
                            self.processProperties(json: anotherData)
                            
                           
                        }
                        catch{
                            print("JSON error: \(error)")
                        }
                    }
                    

        }

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
                return properties.count + 1
              }
            
            
              
              func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
               
                
                  if indexPath.row == 0 {
                      
                  let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
                     return cell
                  }
                  else
                  {
                    
//                      let cell = tableView.dequeueReusableCell(withIdentifier: "tCell", for: indexPath) as! PropertiesTableViewCell
//
                                    let cell = tableView.dequeueReusableCell(withIdentifier: "tCell", for: indexPath) as! PropertiesTableViewCell
                    
                    
                    
                    let mProperties = properties[indexPath.row-1]
                    
                    cell.propertyTypeLabel.text = "\(mProperties.typeName.uppercased()) . \(mProperties.bedrooms) BEDS . \(mProperties.bathrooms) BATHS"
                    cell.propertyNameLabel.text = mProperties.name
                    cell.priceLabel.text = "\(mProperties.currencyShortname) \(mProperties.price) / month"
                    
                    
                    
                    
                    var images: [ZKCarouselSlide] = [ZKCarouselSlide]()
                    //var images: [UIImage] = [UIImage]()
                    //print(mProperties.paths)
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
        
          else{
            return indexPath
        }
                  
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
          let vc = (storyboard?.instantiateViewController(withIdentifier: "detailView") as? propertiesDetailViewController)!
        
        let detailedProperty = properties[indexPath.row - 1]
        let detailedPropertyName = properties[indexPath.row - 1].name
        let detailedDescription = properties[indexPath.row - 1].description
        let detailedCity = properties[indexPath.row - 1].cityName
        let detailedRegion = properties[indexPath.row - 1].regionName
        let detailedPropertyType = properties[indexPath.row - 1].typeName
        let detailedBedrooms = properties[indexPath.row - 1].bedrooms
        let detailedBathrooms = properties[indexPath.row - 1].bathrooms
        let detailedOccupants = properties[indexPath.row - 1].occupants
        let detailedPrice = properties[indexPath.row - 1].price
        let detailedCurrShortname = properties[indexPath.row - 1].currencyShortname
        
        
        
        vc.getDetailedProperty = detailedProperty
        vc.getDetailedPropertyName = detailedPropertyName
        vc.getDetailedDescription = detailedDescription
        vc.getDetailedRegion = detailedRegion
        vc.getDetailedCity = detailedCity
        vc.getDetailedPropertyType = detailedPropertyType
        vc.getDetailedBedrooms = detailedBedrooms
        vc.getDetailedBathrooms = detailedBathrooms
        vc.getDetailedOccupants = detailedOccupants
        vc.getDetailedCurrencyShortname = detailedCurrShortname
        vc.getDetailedPrice = detailedPrice
        
        
//        vc?.imageSlider.slides = properties[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
//        self.present(vc!, animated: true, completion: nil)
    }
    
                       
   

      
    


}
        


