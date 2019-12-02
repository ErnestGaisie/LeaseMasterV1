//
//  SignupPresenter.swift
//  LeaseMaster
//
//  Created by user on 07/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation
import UIKit


private let _Presenter_SharedInstance = SignupPresenter()

class SignupPresenter: ViewToPresenterProtocol {
//    func performMySegue(navigationController: UINavigationController) {
//        <#code#>
//    }
//
    
    class var sharedInstance: SignupPresenter
    {
        return _Presenter_SharedInstance
    }
    
    
    var view: PresenterToViewProtocol?
    var interactor: PresentorToInteractorProtocol? = SignupInteractor()
   
    var router: PresenterToRouterProtocol?
    
    func registerUser(email: String, fullName: String, password: String) {
        interactor?.resgisterUserAPI(email: email, fullName: fullName, password: password )
       
    }
    
    func showNewController(navigationController: UINavigationController) {
        router?.performMySegue(navigationController: navigationController)
        
    }
}

extension SignupPresenter: InteractorToPresenterProtocol {
    func resgisterUserResponseFetched(user : UserDetails) {
         //view?.showStatus(user: user)
        SignUpViewController.sharedInstance.showStatus(user: user)
       
        
    }
    
    func resgistrationSuccessfulPeformSegue(success : Bool) {
         //view?.showStatus(user: user)
//        if success == true{
//
//      let HomeStoryboard: UIStoryboard = UIStoryboard.init(name: "TabBarStoryboard", bundle: nil)
//      let homeScreen = (HomeStoryboard.instantiateViewController(withIdentifier: "tabi") as? UITabBarController)!
//         navigationController?.present(homeScreen, animated: true)
//
//        }
//        else{
//            print("walahi")
//        }
        
    }
    
    func resgisterUserResponseFetchedFailed(message: String) {
        view?.showError(message: message)
//         SignUpViewController.sharedInstance.showError(message: message)
    }
    
    
}
