//
//  SignupGoogleViewController.swift
//  LeaseMaster
//
//  Created by user on 21/10/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit
import GoogleSignIn
import FacebookLogin
import FBSDKLoginKit
import FacebookCore


class SignupGoogleViewController: UIViewController, GIDSignInDelegate {

    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var SignupMomoButton: UIButton!
    @IBOutlet weak var loginStackView: UIStackView!
    @IBAction func googleSignupButtonPressed(_ sender: Any) {
        
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signIn()
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()

    }
    
    
    @IBAction func facebookSignupButtonPressed(_ sender: Any) {
        if(AccessToken.current?.tokenString == nil){
                   print("Not logged in ")
               }else{
                   print("Logged in already")
                   getFacebookUserInfo()
               }
        getFacebookUserInfo()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtonStyle(button:facebookButton)
        setupButtonStyle(button:googleButton)
        setupButtonStyle(button:SignupMomoButton)
        googleButton.layer.borderColor = UIColor.brownGrey.cgColor
        googleButton.layer.borderWidth = 1.0
        
       


    }
    

  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
               withError error: Error!) {
       if let error = error {
         if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
           print("The user has not signed in before or they have since signed out.")
         } else {
           print("\(error.localizedDescription)")
         }
         return
       }
       // Perform any operations on signed in user here.
       let userId = user.userID                  // For client-side use only!
       let idToken = user.authentication.idToken // Safe to send to the server
       let fullName = user.profile.name
       let givenName = user.profile.givenName
       let familyName = user.profile.familyName
       let email = user.profile.email
         
         print(userId!)
          print(idToken!)
          print(fullName!)
          print(givenName!)
          print(familyName!)
          print(email!)
       // ...
     }
    
    
    func getFacebookUserInfo(){
     let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile, .email ], viewController: self) { (result) in
         switch result{
         case .cancelled:
             print("Cancel button click")
         case .success:
             let params = ["fields" : "id, name, first_name, last_name, picture.type(large), email "]
             let graphRequest = GraphRequest.init(graphPath: "/me", parameters: params)
             let Connection = GraphRequestConnection()
             Connection.add(graphRequest) { (Connection, result, error) in
                 let info = result as! [String : AnyObject]
                 print(info["name"] as! String)
             }
             Connection.start()
         default:
             print("??")
         }
    


        }
}

}
