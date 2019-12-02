//
//  ViewController.swift
//  LeaseMaster
//
//  Created by user on 21/10/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit


protocol AdjustAccordingToScreenSizeDelegate{
    
  
    
    func adjustAccordingToScreenSize() -> ()
    
}

  private let _View_SharedInstance = SignUpViewController()

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    class var sharedInstance: SignUpViewController
    {
        return _View_SharedInstance
    }
    
    @IBAction func loginHereButton(_ sender: UIButton) {
        let HomeStoryboard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let loginScreen = (HomeStoryboard.instantiateViewController(withIdentifier: "loginNavigationController") as? UINavigationController)!
            navigationController?.present(loginScreen, animated: true)
        
    }
    @IBOutlet weak var loginhereButton: UIButton!
    var presenter: ViewToPresenterProtocol? = SignupPresenter()
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailTextField: ExpFloatingLabelTextField!
    @IBOutlet weak var fullnameTextField: ExpFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: ExpFloatingLabelTextField!
    @IBOutlet weak var signupLabel: UILabel!
    @IBOutlet weak var signupLabelToSafeAreaSpace: NSLayoutConstraint!
   
    @IBOutlet weak var textView: UITextView!
    
    var email: String {
        emailTextField.text!
    }
    @IBAction func SignupButton(_ sender: Any) {
        SignInButtonPressed()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextfields(textField: emailTextField)
        setupTextfields(textField: fullnameTextField)
        setupTextfields(textField: passwordTextField)
        signupLabel.adjustsFontSizeToFitWidth = true
        adjustAccordingToScreenSize()
        updateTextView()
        
        
             
       myTarget(myTextField: emailTextField)
         myTarget(myTextField: fullnameTextField)
         myTarget(myTextField: passwordTextField)
       
        emailTextField.delegate = self
         fullnameTextField.delegate = self
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
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
//
//        return false
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      
        /// Change status bar color to white
        var preferredStatusBarStyle: UIStatusBarStyle {
            return .default
        }
    }
    
    
    
    
    func SignInButtonPressed() {
        
        presenter!.registerUser(email: emailTextField.text!, fullName: fullnameTextField.text!, password: passwordTextField.text!)

//        presenter?.showNewController(navigationController: navigationController!)
        
        
        let response = Validation.shared.validate(values: (ValidationType.email, emailTextField.text!),  (ValidationType.alphabeticString, fullnameTextField.text!), (ValidationType.password, passwordTextField.text!))
                     switch response {
                     case .success:
                        errorLabel.isHidden = true
                         emailTextField.layer.borderColor = UIColor.veryLightPink.cgColor
                         fullnameTextField.layer.borderColor = UIColor.veryLightPink.cgColor
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
                        
                        if message.localized() == "Please enter your full name" || message.localized() == "Full name is required"{
                        fullnameTextField.layer.borderColor = UIColor.red.cgColor
                        fullnameTextField.layer.borderWidth = 1.0
                        }
                        else{
                            fullnameTextField.layer.borderColor = UIColor.veryLightPink.cgColor
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
    
   
    
    
    func updateTextView()
    {
        let path = "https://www.youtube.com/watch?v=cxFi4rO11uk"
        let text = textView.text ?? ""
        let attributedString = NSAttributedString.makeHyperLink(for: path, in: text, as: "Terms and conditions")
        let font = textView.font
        textView.attributedText = attributedString
        textView.font = font
        
    }
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        fullnameTextField.text = (fullnameTextField.text! as NSString).replacingCharacters(in: range, with: string.uppercased())
//
//        return false
//    }



    @objc func dismissKeyboard(){
       
         fullnameTextField.resignFirstResponder()
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
//        textField.placeholder = " "

    }
    
    @objc func doneEditing (textField: ExpFloatingLabelTextField){
        textField.layer.borderColor = UIColor.veryLightPink.cgColor
    }
//
}








extension SignUpViewController: AdjustAccordingToScreenSizeDelegate
{
   func adjustAccordingToScreenSize()
        {
            // iphone 5s,SE screen height 567
            if (self.view.frame.height < 570) {
                signupLabelToSafeAreaSpace.constant = 45
            }
            // iphone 6,6s,7,etc height 667
            else if (self.view.frame.height > 600 && self.view.frame.height < 730) {
                signupLabelToSafeAreaSpace.constant = 75
            }
            else if (self.view.frame.height > 730 && self.view.frame.height < 800) {
               signupLabelToSafeAreaSpace.constant = 80
            }
                 // iphone 7 plus, 8 plus, xs max,etc height 896
            else if (self.view.frame.height > 800) {
                 signupLabelToSafeAreaSpace.constant = 80
            }

    }
}







extension SignUpViewController: PresenterToViewProtocol {
    
    func showStatus(user: UserDetails){
        let a = user.email
        let b = user.fullName
    }
    
    func showError(message: String) {
        print("cocopods")
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

    
}
