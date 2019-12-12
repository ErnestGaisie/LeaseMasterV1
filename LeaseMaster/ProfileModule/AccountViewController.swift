//
//  AccountViewController.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 18/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit
import Kingfisher


class AccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var userDetails: Login = Login()

    
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBAction func logoutButton(_ sender: UIButton) {
        
        
        UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
        NotificationCenter.default.post(name: Notification.Name("userLoggedIn"), object: false)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onLoginDetailsReceived(notification:)), name: Notification.Name("loginDetailsReceived"), object: nil)
        
        
        let name = Login.shared.fullName
        accountName.text = name
        
        let avatarPath = Login.shared.avatarPath
        print("000000000000000000000000000000000000000000000000")
        print(avatarPath)
        
        if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true {
        
            if avatarPath != nil {
                KingfisherManager.shared.retrieveImage(with: URL(string: Login.shared.avatarPath!)!, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
            self.profileImage.image = image
                                    
                                    })
        }
            else {
                self.profileImage.image = UIImage(named: "user-icon")
            }
        }
        else
        {
             self.profileImage.image = UIImage(named: "user-icon")
        }
        
        profileImage.layer.cornerRadius = profileImage.frame.size.height/2
        profileImage.clipsToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(onLocationsReceived(notification:)), name: Notification.Name("userLoggedIn"), object: nil)
        
       

        // Do any additional setup after loading the view.
    }
    
    @objc func onLocationsReceived(notification: Notification) {
        if false == notification.object as! Bool {
            let HomeStoryboard: UIStoryboard = UIStoryboard.init(name: "TabBarStoryboard", bundle: nil)
            let homeScreen = (HomeStoryboard.instantiateViewController(withIdentifier: "tabi") as? UITabBarController)!
            navigationController?.present(homeScreen, animated: true)
                    
        }
    }
    
    @objc func onLoginDetailsReceived(notification: Notification) {
        if let loginDetails: Login = notification.object as? Login {
            self.userDetails = loginDetails
           print("AHOSHESH£")
            print( self.userDetails.fullName)
            let name = self.userDetails.fullName as String
            print( self.userDetails.email)
            print( self.userDetails.avatarPath)
            print( self.userDetails.default_phone)
            
            print("ALLLOOO")
            print(name)
         
            //accountName.text = name
            

        }
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return 4
        }

        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            if indexPath.row == 0 {
           
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! firstTableViewCell
                
                
                return cell
            }
            else if indexPath.row == 1{
             let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
                
                return cell2
            }
            else if indexPath.row == 2{
             let cell3 = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
                
                return cell3
            }
            else{
                let cell4 = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath)
                return cell4
            }
            //            let item = self.items[indexPath.item]
//            cell.cellLabel.text = item
             

          
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

            return 50

        }
    //    private func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let vw = UIView()
    //        vw.backgroundColor = UIColor.blue
    //
    //        return vw
    //    }
        
        func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
            view.tintColor = UIColor.red
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = UIColor.white
        }


}
