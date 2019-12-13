//
//  LoginInteractor.swift
//  LeaseMaster
//
//  Created by user on 18/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper



class LoginInteractor: LoginPresentorToInteractorProtocol{
    
    
    var presenter: LoginInteractorToPresenterProtocol?

    
    func loginUserAPI(email: String, password: String) {
        print("nkfndlskfk")
        Alamofire.request(Constants.loginURL,
                          method: .post,
                          parameters: [ "email" : email,
                                        "password" : password
            ]
        ).responseJSON { response in
           
            print(response)
            
            if let response = response.result.value{
                let reponseData = JSON(response)
                
                let accessToken = reponseData["access_token"].stringValue
                 print("hi")
                print("\(accessToken)")
                
                Login.shared.accessToken = accessToken
            }
            
           
            if(response.response?.statusCode == 200){
                guard let data = response.data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let loginResponse = try decoder.decode(LoginResponse.self, from: data)
                    let json = try JSON(data: data)
                    guard let data = loginResponse.data else {
                      
                        return
                    }
                    
                   
                     print(data)
                  print("Makoma")
   
                     LoginPresenter.sharedInstance.loginSuccessfulPeformSegue(success: true)
                    NotificationCenter.default.post(name: Notification.Name("userLoggedIn"), object: true)

                    LoginPresenter.sharedInstance.loginUserResponseFetched(member: data)
                    
                    self.processLoginDetails(data: data)
                    
                } catch let error {
                    print(error)
                }
            }
            else  if(response.response?.statusCode == 422) {
                let duplicate = "Email already taken"
                print("swimmping pool")
                LoginPresenter.sharedInstance.loginSuccessfulPeformSegue(success: false)

                self.presenter?.loginUserResponseFetchedFailed(message: duplicate)
            }
            
           else if let value = response.result.value{
                               let apiResponseData = JSON(value)
                              let message = apiResponseData["message"].stringValue
                 self.presenter?.loginUserResponseFetchedFailed(message: message)
                LoginPresenter.sharedInstance.loginSuccessfulPeformSegue(success: false)

                                    
                       }
        }
        

    }
    
    func processLoginDetails(data: LoginDetails) {
        var login = Login()
       
        login.fullName = data.fullName!
        login.avatarPath = data.avatarPath!
        login.email = data.email!
        login.default_phone = data.default_phone!
        
        Login.shared.fullName = data.fullName!
        Login.shared.avatarPath = data.avatarPath!
        Login.shared.email = data.email!
        Login.shared.default_phone = data.default_phone!
        
//        print("AHOSHESH£")
//        print( login.fullName)
//        print( login.avatarPath)
//        print( login.email)
//        print( login.default_phone)
        let loginObject = ["fullName": data.fullName!, "avatarPath": data.avatarPath!, "email": data.email!, "default_phone": data.default_phone!]
        
        //NotificationCenter.default.post(name: Notification.Name("loginDetailsReceived"), object: loginObject)
        
        NotificationCenter.default.post(name: Notification.Name("loginDetailsReceived"), object: login)
        
    }
}
