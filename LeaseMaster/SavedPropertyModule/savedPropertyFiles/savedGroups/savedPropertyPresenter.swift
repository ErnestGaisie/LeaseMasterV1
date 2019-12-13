//
//  savedPropertyPresenter.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 10/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation

private let _savedPropertyPresenter_SharedInstance = savedPropertyPresenter()



class savedPropertyPresenter {
    
        class var sharedInstance: savedPropertyPresenter
        {
            return _savedPropertyPresenter_SharedInstance
        }

    
    public func updateView(){
        savedPropertyInteractor.sharedInstance.requestSavedProperties()
    }
    
    
}
