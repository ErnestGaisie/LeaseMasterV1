//
//  SearchPropertyPresenter.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 25/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import Foundation

private let _SearchPropertyPresenter_Shared_Instance  = SearchPropertyPresenter()

class SearchPropertyPresenter {
    class var sharedInstance: SearchPropertyPresenter
    {
        return _SearchPropertyPresenter_Shared_Instance
    }
    
    func callFetchproperties(location: String){
        print("LOMAKOSA")
        searchPropertyInteractor.sharedInstance.fetchProperties(location: location)
    }

}
