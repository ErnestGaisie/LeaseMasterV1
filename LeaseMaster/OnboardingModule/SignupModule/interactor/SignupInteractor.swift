//
//  SignupInteractor.swift
//  LeaseMaster
//
//  Created by user on 07/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper



class SignupInteractor: PresentorToInteractorProtocol{
    
    var presenter: InteractorToPresenterProtocol?
    
 
    
    

    
    func resgisterUserAPI(email: String, fullName: String, password: String) {
        print("milkshake")
        Alamofire.request(Constants.URL,
                          method: .post,
                          parameters: [ "email" : email,
                                        "name" : fullName,
                                        "password" : password
            ]
        ).responseJSON { response in
            print("hi")
            print(response)
           
            if(response.response?.statusCode == 200){
                guard let data = response.data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let registrationResponse = try decoder.decode(RegistrationResponse.self, from: data)
                    guard let firstUser = registrationResponse.user else {
                       
                        return
                    }
                    
//                    SignupPresenter.performMySegue(SignupPresenter)
                    SignupPresenter.sharedInstance.resgistrationSuccessfulPeformSegue(success: true)
                     print("firstUser")
                     print(firstUser)
                    //self.presenter?.resgisterUserResponseFetched(user: firstUser)
                   SignupPresenter.sharedInstance.resgisterUserResponseFetched(user: firstUser)
                } catch let error {
                    print(error)
                }
            }
            else  if(response.response?.statusCode == 422) {
                let duplicate = "Email already taken"
                print("swimmping pool")
                SignupPresenter.sharedInstance.resgistrationSuccessfulPeformSegue(success: false)

                self.presenter?.resgisterUserResponseFetchedFailed(message: duplicate)
            }
            
           else if let value = response.result.value{
                               let apiResponseData = JSON(value)
                              let message = apiResponseData["message"].stringValue
                 self.presenter?.resgisterUserResponseFetchedFailed(message: message)
                SignupPresenter.sharedInstance.resgistrationSuccessfulPeformSegue(success: false)

                                    
                       }
        }
        

    }
}
