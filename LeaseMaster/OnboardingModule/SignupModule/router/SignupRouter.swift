//
//  SignupRouter.swift
//  LeaseMaster
//
//  Created by user on 14/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation
import UIKit

class SignupRouter: PresenterToRouterProtocol{
    
    static func createModule() -> SignUpViewController{
        let view = mainstoryboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        //if let view = navController.childViewControllers.first as? LiveNewsViewController {
        var presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = SignupPresenter()
        var interactor: PresentorToInteractorProtocol = SignupInteractor()
            let router: PresenterToRouterProtocol = SignupRouter()
            
        view?.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
             interactor.presenter = presenter
            
            return view!
            
        //}
        
        //return UIViewController()
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
   
    
    func performMySegue(navigationController:UINavigationController) {
       
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let controller = storyboard.instantiateViewController(withIdentifier: "AddNumberViewController") as! AddNumberViewController
//        navigationController.pushViewController(controller, animated: true)
//        print("ramen noodles")
        
    }
    
//    func pushToMovieScreen(navigationConroller navigationController:UINavigationController) {
//        
//        let movieModue = MovieRouter.createMovieModule()
//        navigationController.pushViewController(movieModue,animated: true)
//        
//    }
}
