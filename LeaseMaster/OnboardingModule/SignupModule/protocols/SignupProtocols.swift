//
//  protocols.swift
//  LeaseMaster
//
//  Created by user on 07/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation
import UIKit

protocol PresenterToViewProtocol {
    func showStatus(user: UserDetails)
    func showError(message: String)
//    func performMySegue()
}

protocol InteractorToPresenterProtocol {
    func resgisterUserResponseFetched(user: UserDetails)
    func resgisterUserResponseFetchedFailed(message: String)
    func resgistrationSuccessfulPeformSegue(success : Bool)
}

protocol PresentorToInteractorProtocol{
    var presenter: InteractorToPresenterProtocol? {get set}

    func resgisterUserAPI(email: String, fullName: String, password: String)
}

protocol ViewToPresenterProtocol{

    var view: PresenterToViewProtocol? {get set}
    var interactor: PresentorToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func registerUser(email: String, fullName: String, password: String)
     func showNewController(navigationController:UINavigationController)
}

protocol PresenterToRouterProtocol: class {
    static func createModule() -> SignUpViewController
     func performMySegue( navigationController:UINavigationController)
}
