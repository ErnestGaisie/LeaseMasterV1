//
//  saveBottomView.swift
//  LeaseMaster
//
//  Created by Isaac Annan on 10/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

class saveBottomView: UIView {
    
    let propertyImage: UIImageView = {
        let pImage = UIImageView()
        //pImage.backgroundColor = .green
        
        return pImage
    }()
    
    let propertyName: UILabel = {
        let pName = UILabel()
        pName.backgroundColor = .gray
        pName.text = "Beautiful house in East Legon"
        return pName
    }()
    
    
    let propertyLocation: UILabel = {
        let pLocation = UILabel()
        pLocation.backgroundColor = .gray
        pLocation.text = "Ogbojo, East Legon"
        return pLocation
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        combinedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        combinedInit()
    }
    
    func combinedInit(){
        self.addSubview(propertyImage)
        self.addSubview(propertyLocation)
        self.addSubview(propertyName)
        
        
        propertyImage.anchor(top: self.topAnchor,left: self.leftAnchor, paddingTop: 20,  paddingLeft: 24, height: 70, width: 90)
        
        
        propertyName.anchor(top: self.topAnchor, left: propertyImage.rightAnchor,paddingTop: 25, paddingLeft: 10, height: 27, width: 245)
        
        propertyLocation.anchor(top: propertyName.bottomAnchor, left: propertyImage.rightAnchor, paddingTop: 10, paddingLeft: 10, height: 27, width: 245)
    }

}
