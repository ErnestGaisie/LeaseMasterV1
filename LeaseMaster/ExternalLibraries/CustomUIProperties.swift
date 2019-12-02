//
//  CustomUIProperties.swift
//  LeaseMaster
//
//  Created by user on 21/10/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit
open class CustomLabel : UILabel {
    @IBInspectable open var characterSpacing:CGFloat = 1 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: self.characterSpacing, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }

    }
}

//class CustomTextField: SkyFloatingLabelTextField {
//    private let leftPadding = CGFloat(6)
//    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        let rect = CGRect(
//            x: leftPadding,
//            y: titleHeight(),
//            width: bounds.size.width,
//            height: bounds.size.height - titleHeight() - selectedLineHeight
//        )
//        return rect
//    }
//    override func titleLabelRectForBounds(bounds: CGRect, editing: Bool) -> CGRect {
//        if editing {
//            return CGRect(x: leftPadding, y: 0, width: bounds.size.width, height: titleHeight())
//        }
//        return CGRect(x: leftPadding, y: titleHeight(), width: bounds.size.width, height: titleHeight())
//    }
//}

extension UIColor {
    class var savRadialBlue: UIColor {
        return UIColor(red: 50.0 / 255.0, green: 104.0 / 255.0, blue: 183.0 / 255.0, alpha: 1.0)
    }
    
    class var savRadialBluish: UIColor {
        return UIColor(red: 44.0 / 255.0, green: 37.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
    }
    
    class var savRadialPurple: UIColor {
        return UIColor(red: 53.0 / 255.0, green: 37.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
    }
    
    class var savTurqouise: UIColor {
        return UIColor(red: 116.0 / 255.0, green: 244.0 / 255.0, blue: 198.0 / 255.0, alpha: 1.0)
    }
    
    
    class var expBlueyGrey: UIColor {
        return UIColor(red: 142.0 / 255.0, green: 153.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
    }
    
    class var expWhite: UIColor {
        return UIColor(white: 255.0 / 255.0, alpha: 1.0)
    }
    
    class var expAzure: UIColor {
        return UIColor(red: 1.0 / 255.0, green: 149.0 / 255.0, blue: 231.0 / 255.0, alpha: 1.0)
    }
    
    class var expGreyblue: UIColor {
        return UIColor(red: 106.0 / 255.0, green: 121.0 / 255.0, blue: 141.0 / 255.0, alpha: 1.0)
    }
    
   class var veryLightPink: UIColor {
       return UIColor(red: 235.0 / 255.0, green: 235.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0)
   }

    class var  brownGrey: UIColor {
        return UIColor(red: 151 / 255.0, green: 151.0 / 255.0, blue: 151.0 / 255.0, alpha: 0.6)
      }
    
    class var  LeaseMasterOrange: UIColor {
        return UIColor(red: 243 / 255.0, green: 116.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0)
    }
    
    class var  LeaseMasterGray: UIColor {
         return UIColor(red: 72 / 255.0, green: 72 / 255.0, blue: 72 / 255.0, alpha: 0.6)
       }
   
  
}

func setupTextfields(textField: ExpFloatingLabelTextField){
    textField.layer.cornerRadius = 4.0
    textField.layer.borderWidth = 1.0
    textField.layer.borderColor = UIColor.veryLightPink.cgColor
    
    
     // Create a padding view for padding on left
    textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
    textField.leftViewMode = .always
           
    // Create a padding view for padding on right
//    textField.rightView = ExpFloatingLabelTextField(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
//    textField.rightViewMode = .always
    
//     textField(frame: CGRect(x: 10, y: 10, width: 120, height: 45))
    textField.textColor = .black
           textField.font = UIFont(name:"Gilroy-Medium", size: 16)
           textField.titleColor = UIColor.LeaseMasterOrange
    textField.tintColor = UIColor.LeaseMasterOrange
           textField.selectedTitleColor = UIColor.LeaseMasterOrange
    
   
      textField.errorColor = UIColor.red
    textField.titleFormatter = {
        
        (text:String) in return text
    }
    
//    let textView = SkyFloatingLabelTextField(frame: .zero)
//    textView.titleFormatter = { (text: String) -> String in
//        //Or what ever you want
//        return text.font
//        
//    }
           textField.lineHeight = 0
           textField.placeholderColor = UIColor.lightGray
           textField.selectedLineHeight = 0
  
 
   
}

func setupPropertyTextfields(textField:UITextField){
textField.layer.cornerRadius = 4.0
textField.layer.borderWidth = 1.0
textField.layer.borderColor = UIColor.veryLightPink.cgColor


 // Create a padding view for padding on left
textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
textField.leftViewMode = .always
       
// Create a padding view for padding on right
textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
textField.rightViewMode = .always
}

func setupButtonStyle(button:UIButton){
       button.layer.cornerRadius = 4.0
       
   }
