//
//  LoginSecurityViewController.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 18/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

class LoginSecurityViewController: UIViewController {

    @IBOutlet weak var currentPassword: UITextField!
    
    
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var confirmNewPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAccountTextfields(textField: currentPassword)
        setupAccountTextfields(textField: newPassword)
        setupAccountTextfields(textField: confirmNewPassword)
        // Do any additional setup after loading the view.
    }
    
    func setupAccountTextfields(textField:UITextField){
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

}
