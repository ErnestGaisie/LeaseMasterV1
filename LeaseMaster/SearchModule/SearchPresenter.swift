//
//  SearchPresenter.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 18/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation

private let _SearchPresenter_Shared_Instance  = SearchPresenter()

class SearchPresenter {
    class var sharedInstance: SearchPresenter
    {
        return _SearchPresenter_Shared_Instance
    }
    
    func queryLocations() {
        SearchInteractor.sharedInstance.requestLocations()
    }
    
}
