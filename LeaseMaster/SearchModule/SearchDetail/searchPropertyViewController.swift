//
//  searchPropertyViewController.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 25/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Kingfisher


class searchPropertyViewController: UIViewController {
    
    var properties: [searchedProperty] = [searchedProperty]()

    @IBOutlet weak var searchPropertyTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CircularSpinner.trackPgColor = .LeaseMasterOrange
        CircularSpinner.show()
        NotificationCenter.default.addObserver(self, selector: #selector(onPropertiesReceived(notification:)), name: Notification.Name("searchedPropertiesReceived"), object: nil)
    
    }
    
    @objc func onPropertiesReceived(notification: Notification)
    {
        if let properties: [searchedProperty] = notification.object as? [searchedProperty]
        {
            self.properties = properties
            self.searchPropertyTableView.reloadData()
            CircularSpinner.hide()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension searchPropertyViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchPropertyTableView.dequeueReusableCell(withIdentifier: "propertyCell") as? searchPropertyTableViewCell
        
        let property = properties[indexPath.row]
        
        cell?.nameLabel.text = property.name
        cell?.priceLabel.text = "\(property.price) GHS"
        
        //let imagePaths = property.paths
        //print(property.paths)
        
        //cell?.property = property.paths
        
        var images: [ZKCarouselSlide] = [ZKCarouselSlide]()
        print("the properties")
        print(property.paths)
        for i in property.paths{
            
           
                                  

                                  KingfisherManager.shared.retrieveImage(with: URL(string: i)!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                                     
                                      let slide = ZKCarouselSlide(image: image!, title: "", description: "")
                                      
                                      images += [slide]
                                      cell?.carouselView.slides = images
                                  
                                  })
                                     
                                   
                            
                                  
//
//                    Alamofire.request(i).responseImage{ response in
//                        if let image = response.result.value {
//                            //print("image downloaded: \(image)/ \(indexPath.row)")
//                            let slide = ZKCarouselSlide(image: image, title: "", description: "")
//                            images += [slide]
//
//                            cell?.carouselView.slides = images
//                        }
//                    }
        
                }
        
        
        
        
        return cell!
    }
    
    
}
