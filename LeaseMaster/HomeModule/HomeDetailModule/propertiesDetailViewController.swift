//
//  propertiesDetailViewController.swift
//  LeaseMaster
//
//  Created by Isaac Annan on 28/10/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit
import Kingfisher

class propertiesDetailViewController: UIViewController {
      var images: [ZKCarouselSlide] = [ZKCarouselSlide]()

    @IBOutlet weak var imageSlider: ZKCarousel!
    var getDetailedProperty: property?
    var getDetailedPropertyName: String?
    var getDetailedDescription: String?
    var getDetailedOccupants: Int?
    var getDetailedBedrooms: Int?
    var getDetailedBathrooms: Int?
    var getDetailedPropertyType: String?
    var getDetailedCity: String?
    var getDetailedRegion: String?
    var getDetailedCurrencyShortname:String?
    var getDetailedPrice:String?
    var isMyUserLoggedIn: Bool = false
    
 let tBar = TabBarViewController()
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var typeNameLabel: UILabel!
    
    @IBOutlet weak var propertyName: UILabel!
    
    
    @IBOutlet weak var bedrooms: UILabel!
    @IBOutlet weak var bathrooms: UILabel!
    
    @IBOutlet weak var propertyDescription: UITextView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var loginView: UIView!
    
 @IBOutlet weak var increaseHeightConstraint: NSLayoutConstraint!
    
   @IBOutlet weak var contactOwnerView: UIView!
    
    
    let theView: UIView = {
        let view = UIView()
        //view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        view.backgroundColor = .white
        return view
    }()
    
    let requestContactButton: UIButton = {
        let rbutton = UIButton()
        rbutton.setTitle("Request Contact", for: .normal)
        rbutton.titleLabel?.font = UIFont(name: "Gilroy-Bold", size: 15)
        rbutton.frame  = CGRect(x: 0, y: 0, width: 179, height: 48)
        rbutton.backgroundColor = .orange
        return rbutton
    }()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if isMyUserLoggedIn == false {
            loginView.isHidden = false
            contactOwnerView.isHidden = true
            increaseHeightConstraint.constant = 0
            
        }
        else
        if isMyUserLoggedIn == true {
                loginView.isHidden = true
       contactOwnerView.isHidden = false
        increaseHeightConstraint.constant = 120
                   
               }
        
        theView.layer.shadowOpacity = 0.05
    //    bottomView.layer.shadowOpacity = 0.05
        print("hamcheesegoatmilk")
//        print(getDetailedPropertyName)
//        print(getDetailedProperty)
//        print(getDetailedProperty?.bedrooms)
//        print(getDetailedDescription)
        print(getDetailedCity)
        print(getDetailedRegion)
        
        for imagePath in getDetailedProperty!.paths{
        
                  print(imagePath)

                  KingfisherManager.shared.retrieveImage(with: URL(string: imagePath)!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
                    let slide = ZKCarouselSlide(image: image!, title: "", description: "")
                    
                    self.images += [slide]
                    self.imageSlider.slides = self.images
                  
                  })
  
        }
        theView.translatesAutoresizingMaskIntoConstraints = false
        requestContactButton.translatesAutoresizingMaskIntoConstraints = false
        theView.addSubview(requestContactButton)
        view.addSubview(theView)
        
//        imageSlider.imgArray = imgArray
        
        NSLayoutConstraint(item: requestContactButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 48).isActive = true
        NSLayoutConstraint(item: requestContactButton, attribute: .trailing, relatedBy: .equal, toItem: theView, attribute: .trailing, multiplier: 1.0, constant: -24).isActive = true
        
        NSLayoutConstraint(item: requestContactButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 179).isActive = true
        
        NSLayoutConstraint(item: requestContactButton, attribute: .top, relatedBy: .equal, toItem: theView, attribute: .top, multiplier: 1.0, constant: 16).isActive = true
        
        
        NSLayoutConstraint(item: theView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 101).isActive = true
        NSLayoutConstraint(item: theView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: theView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint(item: theView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -tBar.tabBar.frame.height).isActive = true
        
        
        
        
        self.propertyDescription.text = getDetailedDescription
        self.propertyName.text = getDetailedPropertyName
        self.locationLabel.text = "\(String(describing: getDetailedCity!)), \(String(describing: getDetailedRegion!))"
        self.bathrooms.text = "\(String(describing: getDetailedBathrooms!))"
        self.bedrooms.text = "\(String(describing: getDetailedBedrooms!))"
        self.typeNameLabel.text = getDetailedPropertyType
//        self.priceLabel.text = "\(getDetailedCurrencyShortname!) \(getDetailedPrice!)"
//        self.priceLabel.text = "100000000000000"
        
    }
    
    
    @IBAction func didPressRequestContact(_ sender: Any) {
        
        
    }
    
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        contactOwnerView.isHidden = false
        isMyUserLoggedIn = true
        if isMyUserLoggedIn == true {
            loginView.isHidden = true
            contactOwnerView.isHidden = false
            increaseHeightConstraint.constant = 120
                          
        }
    }
    
    
    
}


 
@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
   
}

