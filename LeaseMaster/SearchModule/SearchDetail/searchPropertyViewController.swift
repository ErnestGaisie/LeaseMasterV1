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
import SkeletonView

private let _SearchPropertyView_Shared_Instance  = searchPropertyViewController()
class searchPropertyViewController: UIViewController {
    class var sharedInstance: searchPropertyViewController
       {
           return _SearchPropertyView_Shared_Instance
       }
    
    var properties: [searchedProperty] = [searchedProperty]()
    var location: String = ""
    var receivedStatus = false

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchPropertyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.text = "   \(location)"
        searchTextField.borderStyle = .none
        searchTextField.layer.masksToBounds = false
        searchTextField.layer.cornerRadius = 4.0;
        searchTextField.layer.backgroundColor = UIColor.white.cgColor
        searchTextField.layer.borderColor = UIColor.clear.cgColor
        searchTextField.layer.shadowColor = UIColor.black.cgColor
        searchTextField.layer.shadowOffset = CGSize(width: 0, height: 0)
        searchTextField.layer.shadowOpacity = 0.2
        searchTextField.layer.shadowRadius = 4.0
        searchTextField.isUserInteractionEnabled = false

            NotificationCenter.default.addObserver(self, selector: #selector(self.onPropertiesReceived(notification:)), name: Notification.Name("searchedPropertiesReceived"), object: nil)
        
    }
    
    @objc func onPropertiesReceived(notification: Notification)
    {
        if let properties: [searchedProperty] = notification.object as? [searchedProperty]
        {
            self.properties = properties
            self.searchPropertyTableView.reloadData()
                
        }
    }

}

extension searchPropertyViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
        let cell1 = searchPropertyTableView.dequeueReusableCell(withIdentifier: "labelCell") as? labelTableViewCell
            
            cell1?.labelText.text = "\(properties.count) properties found"
            
            return cell1!
        }
        else
        {
        let cell = searchPropertyTableView.dequeueReusableCell(withIdentifier: "propertyCell") as? searchPropertyTableViewCell
        
        let property = properties[indexPath.row - 1]
        
        cell?.nameLabel.text = property.name
        cell?.priceLabel.text = "\(property.price) GHS"
            
        cell?.nameLabel.showAnimatedGradientSkeleton()
        cell?.priceLabel.showAnimatedGradientSkeleton()
        cell?.carouselView.showAnimatedGradientSkeleton()

            let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { timer in
                
                cell?.nameLabel.hideSkeleton()
                                    cell?.priceLabel.hideSkeleton()
                                        cell?.carouselView.hideSkeleton()
            })
            
                 
        var images: [ZKCarouselSlide] = [ZKCarouselSlide]()
       // print("the properties")
       // print(property.paths)
        for i in property.paths{
                                  KingfisherManager.shared.retrieveImage(with: URL(string: i)!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                                     
                                      let slide = ZKCarouselSlide(image: image!, title: "", description: "")
                                      
                                      images += [slide]
                                      cell?.carouselView.slides = images
                                  
                                  })
        
                }
        
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        if indexPath.row == 0 {
            return 77
        }
        else
        {
            return 330
        }
    }

}
