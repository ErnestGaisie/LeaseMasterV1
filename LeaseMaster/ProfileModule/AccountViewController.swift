//
//  AccountViewController.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 18/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBAction func logoutButton(_ sender: UIButton) {
        let HomeStoryboard: UIStoryboard = UIStoryboard.init(name: "TabBarStoryboard", bundle: nil)
        let homeScreen = (HomeStoryboard.instantiateViewController(withIdentifier: "tabi") as? UITabBarController)!
        navigationController?.present(homeScreen, animated: true)
                UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.frame.size.height/2
        profileImage.clipsToBounds = true

        // Do any additional setup after loading the view.
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
           
               let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                
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
