//
//  ResetPasswordInteractor.swift
//  LeaseMaster
//
//  Created by user on 20/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper



class ResetPasswordInteractor: PasswordResetPresentorToInteractorProtocol{
    var presenter: PasswordResetInteractorToPresenterProtocol?
    
    func passwordUserAPI(email: String) {
        Alamofire.request(Constants.loginURL,
                          method: .post,
                          parameters: [ "email" : email,
                                       
            ]
        ).responseJSON { response in
            print("hi")
            print(response)
           
            if(response.response?.statusCode == 200){
                guard let data = response.data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let loginResponse = try decoder.decode(LoginResponse.self, from: data)
                    guard let data = loginResponse.data else {
                       
                        return
                    }
                    
                    SignupPresenter.sharedInstance.resgistrationSuccessfulPeformSegue(success: true)
                     print("data")
                     print(data)

                    LoginPresenter.sharedInstance.loginUserResponseFetched(member: data)
                } catch let error {
                    print(error)
                }
            }
            else  if(response.response?.statusCode == 422) {
                let duplicate = "Email already taken"
                print("swimmping pool")
                LoginPresenter.sharedInstance.loginSuccessfulPeformSegue(success: false)

//                self.presenter?.loginUserResponseFetchedFailed(message: duplicate)
            }
            
           else if let value = response.result.value{
                               let apiResponseData = JSON(value)
                              let message = apiResponseData["message"].stringValue
//                 self.presenter?.loginUserResponseFetchedFailed(message: message)
                LoginPresenter.sharedInstance.loginSuccessfulPeformSegue(success: false)

                                    
                       }
        }
        

    }
}
