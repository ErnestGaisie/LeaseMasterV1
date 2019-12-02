//
//  LoginProtocols.swift
//  LeaseMaster
//
//  Created by user on 18/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation
import UIKit

//Login Protocols


protocol LoginPresenterToViewProtocol {
    func showStatus(member: LoginDetails)
    func showError(message: String)
    func loginChecked(status: Bool)
//    func performMySegue()
}

protocol LoginInteractorToPresenterProtocol {
    func loginUserResponseFetched(member: LoginDetails)
    func loginUserResponseFetchedFailed(message: String)
    func loginSuccessfulPeformSegue(success : Bool)
}

protocol LoginPresentorToInteractorProtocol{
    var presenter: LoginInteractorToPresenterProtocol? {get set}

    func loginUserAPI(email: String, password: String)
}

protocol LoginViewToPresenterProtocol{

    var view: LoginPresenterToViewProtocol? {get set}
    var interactor: LoginPresentorToInteractorProtocol? {get set}
    var router: LoginPresenterToRouterProtocol? {get set}
    func loginUser(email: String, password: String)
     func showNewController(navigationController:UINavigationController)
}

protocol LoginPresenterToRouterProtocol: class {
    static func createModule() -> LoginViewController
     func performMySegue( navigationController:UINavigationController)
}
