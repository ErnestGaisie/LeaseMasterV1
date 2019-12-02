//
//  LoginViewController.swift
//  LeaseMaster
//
//  Created by user on 23/10/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import FacebookCore

 private let _View_SharedInstance = LoginViewController()
class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var loginStatus: Bool?
    
    class var sharedInstance: LoginViewController
    {
        return _View_SharedInstance
    }
    
     var presenter: LoginViewToPresenterProtocol? = LoginPresenter()
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: ExpFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: ExpFloatingLabelTextField!
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        print("you've pressed me")
         //loginStatus = true
        if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true{
            print("chicken")
                  let HomeStoryboard: UIStoryboard = UIStoryboard.init(name: "TabBarStoryboard", bundle: nil)
                  let homeScreen = (HomeStoryboard.instantiateViewController(withIdentifier: "tabi") as? UITabBarController)!
                  navigationController?.present(homeScreen, animated: true)
                
              }
              else{
                        print("Login Unsuccessful")
                    }

        LoginButtonPressedValidateTextFields()
    }
    
    @IBAction func showPassword(_ sender: UIButton) {
        if sender.isSelected {
            passwordTextField.isSecureTextEntry = true
//            sender.setImage(., for: .normal)
               }else{
                    passwordTextField.isSecureTextEntry = false
               }
               sender.isSelected = !sender.isSelected
    }
    
    @IBAction func loginBackButton(_ sender: UIBarButtonItem) {
        let HomeStoryboard: UIStoryboard = UIStoryboard.init(name: "TabBarStoryboard", bundle: nil)
               let homeScreen = (HomeStoryboard.instantiateViewController(withIdentifier: "tabi") as? UITabBarController)!
         navigationController?.present(homeScreen, animated: true)
    }
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextfields(textField: emailTextField)
        setupTextfields(textField: passwordTextField)
        setupButtonStyle(button:facebookButton)
        setupButtonStyle(button:googleButton)
        setupButtonStyle(button:loginButton)
        googleButton.layer.borderColor = UIColor.brownGrey.cgColor
        googleButton.layer.borderWidth = 1.0
        myTarget(myTextField: emailTextField)
              
               myTarget(myTextField: passwordTextField)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                    view.addGestureRecognizer(tap)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillShowNotification, object: nil)
             
            
             
    }
    
    func myTarget(myTextField: ExpFloatingLabelTextField){
           myTextField.addTarget(self, action: #selector(self.textFieldEditing(textField:)), for: .editingDidBegin)
                  myTextField.addTarget(self, action: #selector(self.doneEditing(textField:)), for: .editingDidEnd)
       }
       
       
       
    

   
    override func viewWillDisappear(_ animated: Bool) {
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
           
           /// Change status bar color to white
          var preferredStatusBarStyle: UIStatusBarStyle {
               return .default
           }

       }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      
        /// Change status bar color to white
        var preferredStatusBarStyle: UIStatusBarStyle {
            return .default
        }
    }
    
    
    @objc func dismissKeyboard(){
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        view.endEditing(true)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        // countryPicker.isHidden = false
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += 0
        }
    }



      @objc func textFieldEditing(textField: ExpFloatingLabelTextField) {

    //     if emailTextField.becomeFirstResponder() == true{
    //          emailTextField.placeholder = nil
    //     }
            textField.layer.borderColor = UIColor.LeaseMasterOrange.cgColor
    //            textField.placeholder = nil

        }
        
        @objc func doneEditing (textField: ExpFloatingLabelTextField){
            textField.layer.borderColor = UIColor.veryLightPink.cgColor
        }
    //
    


 

        
     
    

    
   
    
    
    
    
    
    func LoginButtonPressedValidateTextFields() {
        
        presenter!.loginUser(email: emailTextField.text!, password: passwordTextField.text!)
        
        let response = Validation.shared.validate(values: (ValidationType.email, emailTextField.text!), (ValidationType.password, passwordTextField.text!))
                     switch response {
                     case .success:
                        errorLabel.isHidden = true
                         emailTextField.layer.borderColor = UIColor.veryLightPink.cgColor
                          passwordTextField.layer.borderColor = UIColor.veryLightPink.cgColor
                         break
                        
                        
                        
                     case .failure(_, let message):
                         print(message.localized())
                     
                         errorLabel.isHidden = false
                         errorLabel.text = message.localized()
                         
                         if message.localized() == "Enter a valid email address" || message.localized() == "Email address is required"{
                         
                          emailTextField.layer.borderColor = UIColor.red.cgColor
                          emailTextField.layer.borderWidth = 1.0
                        }
                         else{
                             emailTextField.layer.borderColor = UIColor.veryLightPink.cgColor
                         }
                        
                      
                        
                        if message.localized() == "Password must be 6 characters or more" || message.localized() == "Please create a password"{
                        passwordTextField.layer.borderColor = UIColor.red.cgColor
                        passwordTextField.layer.borderWidth = 1.0
                        }
                        else{
                            passwordTextField.layer.borderColor = UIColor.veryLightPink.cgColor
                        }


                        
                  
                     }
    }
    
   
    
    
   



    
}













extension LoginViewController: LoginPresenterToViewProtocol {
    func showStatus(member: LoginDetails) {
        let userEmail = member.email
        let userName = member.fullName
       // let userNumber = member.default_phone
        let userAvatar = member.avatar
    }
    
    
    func showError(message: String) {
        print("cocopods")
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func loginChecked(status: Bool){
        loginStatus = status
        
        UserDefaults.standard.set(status, forKey: "ISUSERLOGGEDIN")
        print(loginStatus!)
        print("ostrich")
        
        
      
    }
    

    
}
