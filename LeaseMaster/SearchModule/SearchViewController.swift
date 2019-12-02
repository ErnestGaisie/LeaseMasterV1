//
//  SearchViewController.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 18/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit
import SHSearchBar

class SearchViewController: UIViewController, SHSearchBarDelegate {
    
    var locations: [Location] = [Location]()
    var searchLocation: [Location] = [Location]()
    
    var searching = false
    var selectedLocation = ""
    
    var rasterSize : CGFloat = 11.0
    var searchBar1: SHSearchBar!
    var viewConstraints: [NSLayoutConstraint]?
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func backButton(_ sender: Any) {
        
              let HomeStoryboard: UIStoryboard = UIStoryboard.init(name: "TabBarStoryboard", bundle: nil)
              let homeScreen = (HomeStoryboard.instantiateViewController(withIdentifier: "tabi") as? UITabBarController)!
        navigationController?.present(homeScreen, animated: true)
     //   navigationController?.popToViewController(homeScreen, animated: true)
//        popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // let searchGlassIconTemplate = UIImage(named: "icon-search")!.withRenderingMode(.alwaysTemplate)
        // let leftView3 = imageViewWithIcon(searchGlassIconTemplate, rasterSize: rasterSize)
        searchBar1 = defaultSearchBar(withRasterSize: rasterSize, leftView: nil, rightView: nil , delegate: self,useCancelButton: true)
        searchBar1.text = NSLocalizedString("", comment: "")
        view.addSubview(searchBar1)
        
        
        SearchPresenter.sharedInstance.queryLocations()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onLocationsReceived(notification:)), name: Notification.Name("locationsReceived"), object: nil)
        
        setupLayoutConstraints()
        
        
    }
    
    func setupLayoutConstraints(){
        
        let searchBarHeight: CGFloat = 44.0
        
        viewConstraints?.forEach { $0.isActive = false }
        
        let constraints = [
            searchBar1.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
            searchBar1.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 14),
            searchBar1.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -14),
            searchBar1.heightAnchor.constraint(equalToConstant: searchBarHeight),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        if viewConstraints != nil {
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
        viewConstraints = constraints
        
    }
    
    @objc func onLocationsReceived(notification: Notification){
        if let locations: [Location] = notification.object as? [Location]
        {
            self.locations = locations
            self.tableView.reloadData()
            
        }
    }
    
    func defaultSearchBar(withRasterSize rasterSize: CGFloat, leftView: UIView?, rightView: UIView?, delegate: SHSearchBarDelegate, useCancelButton: Bool = true) -> SHSearchBar {
        var config = defaultSearchBarConfig(rasterSize)
        //config.leftView = leftView
        config.rightView = rightView
        config.useCancelButton = useCancelButton
        
        if leftView != nil {
            config.leftViewMode = .always
        }
        
        if rightView != nil {
            config.rightViewMode = .unlessEditing
        }
        
        let bar = SHSearchBar(config: config)
        bar.delegate = delegate
        bar.placeholder = NSLocalizedString("Search by location", comment: "")
        bar.updateBackgroundImage(withRadius: 6, corners: [.allCorners], color: UIColor.white)
        bar.layer.shadowColor = UIColor.black.cgColor
        bar.layer.shadowOffset = CGSize(width: 0, height: 3)
        bar.layer.shadowRadius = 5
        bar.layer.shadowOpacity = 0.25
        return bar
    }
    
    func defaultSearchBarConfig(_ rasterSize: CGFloat) -> SHSearchBarConfig {
        var config: SHSearchBarConfig = SHSearchBarConfig()
        config.rasterSize = rasterSize
        //    config.cancelButtonTitle = NSLocalizedString("sbe.general.cancel", comment: "")
        config.cancelButtonTextAttributes = [.foregroundColor : UIColor.orange]
        config.textContentType = UITextContentType.fullStreetAddress.rawValue
        config.textAttributes = [.foregroundColor : UIColor.gray]
        return config
    }
    
    func imageViewWithIcon(_ icon: UIImage, rasterSize: CGFloat) -> UIImageView {
        let imgView = UIImageView(image: icon)
        imgView.frame = CGRect(x: 0, y: 0, width: icon.size.width + rasterSize * 2.0, height: icon.size.height)
        imgView.contentMode = .center
        imgView.tintColor = UIColor(red: 0.75, green: 0, blue: 0, alpha: 1)
        return imgView
    }
    
    
    
    func searchBar(_ searchBar: SHSearchBar, textDidChange text: String) {
        searchLocation = locations.filter({$0.name.lowercased().contains(text.lowercased())})
        searching = true
        tableView.reloadData()
        
    }
    
    func searchBarShouldCancel(_ searchBar: SHSearchBar) -> Bool {
        searching = false
        searchBar1.text = ""
        tableView.reloadData()
        
        return true
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
            return searchLocation.count
        }
        else
        {
            return locations.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SearchTableViewCell
        
        let location = locations[indexPath.row]
        
        if searching{
            cell?.locationLabel.text = searchLocation[indexPath.row].name
        }
        else
        {
            cell?.locationLabel.text = location.name
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchPropertyTableView: searchPropertyViewController = searchPropertyViewController()
        if searching{
            selectedLocation = searchLocation[indexPath.row].slug
            SearchPropertyPresenter.sharedInstance.callFetchproperties(location: selectedLocation)
            
        }
        else
        {
            selectedLocation = locations[indexPath.row].slug
            SearchPropertyPresenter.sharedInstance.callFetchproperties(location: selectedLocation)
            
        }
        let storyboard = UIStoryboard.init(name: "Search", bundle: nil)
        
        let foundPropertiesViewController = (storyboard.instantiateViewController(withIdentifier: "foundProperties") as? searchPropertyViewController)!
        
        
        navigationController?.pushViewController(foundPropertiesViewController, animated: true)
        
        //tableView.reloadData()
    }
    
    
    
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchLocation = locations.filter({$0.name.lowercased().contains(searchText.lowercased())})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
    
}


