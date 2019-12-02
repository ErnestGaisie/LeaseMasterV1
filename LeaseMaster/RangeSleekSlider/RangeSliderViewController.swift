//
//  RangeSliderViewController.swift
//  LeaseMaster
//
//  Created by user on 28/10/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

class RangeSliderViewController: UIViewController {

    @IBOutlet weak var rangeSlider: RangeSeekSlider!
    @IBOutlet weak var minPrice: UILabel!
    @IBOutlet weak var maxPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

           rangeSlider.delegate = self
       setupLabels(label:minPrice)
         setupLabels(label:maxPrice)
        
    }
    
   func setupLabels(label:UILabel){
        label.layer.cornerRadius = 4.0
        label.layer.borderWidth = 1.0
        label.layer.borderColor = UIColor.veryLightPink.cgColor
        
        
//         // Create a padding view for padding on left
//        label.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: label.frame.height))
//        label.leftViewMode = .always
//               
//        // Create a padding view for padding on right
//        label.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: label.frame.height))
//        label.rightViewMode = .always
       
    }
}



//// MARK: - RangeSeekSliderDelegate
//
extension RangeSliderViewController: RangeSeekSliderDelegate {

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === rangeSlider {
            print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
            let a = Int(minValue)
            let b = Int(maxValue)
            minPrice.text = "¢ " + "\(a)"
              maxPrice.text = "¢ " + "\(b)"
        }
        else{
            print("blahjhhhh")
        }
    }

    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }

    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}
