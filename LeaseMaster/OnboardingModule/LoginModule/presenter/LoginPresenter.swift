//
//  LoginPresenter.swift
//  LeaseMaster
//
//  Created by user on 18/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//



import Foundation
import UIKit


private let _LoginPresenter_SharedInstance = LoginPresenter()

class LoginPresenter: LoginViewToPresenterProtocol {
    
    
    var view: LoginPresenterToViewProtocol?
    
    var interactor: LoginPresentorToInteractorProtocol? = LoginInteractor()
    
    var router: LoginPresenterToRouterProtocol?
    
   
    
    class var sharedInstance: LoginPresenter
    {
        return _LoginPresenter_SharedInstance
    }
    
   
    
    func loginUser(email: String, password: String) {
        print("something is going on")
        interactor?.loginUserAPI(email: email, password: password)
       
    }
    
    func showNewController(navigationController: UINavigationController) {
        router?.performMySegue(navigationController: navigationController)
        
    }
}

extension LoginPresenter: LoginInteractorToPresenterProtocol {
    func loginUserResponseFetched(member : LoginDetails) {
         //view?.showStatus(user: user)
       LoginViewController.sharedInstance.showStatus(member: member)
//        LoginViewController.sharedInstance
        
    }
    
    func loginSuccessfulPeformSegue(success : Bool) {
//        let status = success
//        print("koala")
//        print(status)
        LoginViewController.sharedInstance.loginChecked(status: success)
    }
    
    
    func loginUserResponseFetchedFailed(message: String) {
        view?.showError(message: message)
//         SignUpViewController.sharedInstance.showError(message: message)
    }
    
    
}

