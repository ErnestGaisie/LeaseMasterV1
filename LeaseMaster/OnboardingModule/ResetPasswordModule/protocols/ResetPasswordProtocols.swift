//
//  ResetPasswordProtocols.swift
//  LeaseMaster
//
//  Created by user on 20/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation
import UIKit


protocol PasswordResetPresenterToViewProtocol {
    func showStatus(member: LoginDetails)
    func showError(message: String)

}

protocol PasswordResetInteractorToPresenterProtocol {
    func passwordResetResponseFetched(member: LoginDetails)
    func passwordResetResponseFetchedFailed(message: String)
    func passwordResetSuccessfulPeformSegue(success : Bool)
}

protocol PasswordResetPresentorToInteractorProtocol{
    var presenter: PasswordResetInteractorToPresenterProtocol? {get set}

    func passwordUserAPI(email: String)
}

protocol PasswordResetViewToPresenterProtocol{

    var view: PasswordResetPresenterToViewProtocol? {get set}
    var interactor: PasswordResetPresentorToInteractorProtocol? {get set}
    var router: PasswordResetPresenterToRouterProtocol? {get set}
    func resetPassword(email: String, password: String)
     func showNewController(navigationController:UINavigationController)
}

protocol PasswordResetPresenterToRouterProtocol: class {
    static func createModule() -> ResetPasswordViewController
     func performMySegue( navigationController:UINavigationController)
}
