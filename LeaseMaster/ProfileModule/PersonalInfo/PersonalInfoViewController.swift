//
//  PersonalInfoViewController.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 19/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

private let _PersonalInfoView_Shared_Instance = PersonalInfoViewController()

class PersonalInfoViewController: UIViewController {
    
    class var sharedInstance: PersonalInfoViewController
    {
        return _PersonalInfoView_Shared_Instance
    }
    
    var selectedIndex: Int = -1
    var cellsExpanded: [Bool] = [false,false,false]
    

    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var personalInfoTableView: UITableView!
    
    @IBAction func changePhoto(_ sender: UIButton) {
        
        print("you've pressed me")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personalInfoTableView.showsVerticalScrollIndicator = false
        profilePhoto.layer.cornerRadius = profilePhoto.frame.size.height/2
        profilePhoto.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    

}

extension PersonalInfoViewController: UITableViewDelegate, UITableViewDataSource, customCellDelegate{
    func updateTableView(row: Int) {
        if selectedIndex == row{
                  selectedIndex = -1
              }
              else
              {
                  selectedIndex = row
              }
              
              let path: NSIndexPath = NSIndexPath(row: row, section: 0)
              self.personalInfoTableView.beginUpdates()
              self.personalInfoTableView.reloadRows(at: [path as IndexPath], with: UITableView.RowAnimation.automatic)
              self.personalInfoTableView.endUpdates()
            self.personalInfoTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let  cell = personalInfoTableView.dequeueReusableCell(withIdentifier: "cell1") as! PersonalInfoDetailTableViewCell
        
//        func didTapEditButton(){
               
//        }
       
        
        if indexPath.row == 0 {
            cell.cellLabel.text = "Full Name"
            cell.editButtonReference.tag = indexPath.row
            cell.cancelButtonReference.tag = indexPath.row
            cell.cellTextfield.text = "Ernest Boamah Gaisie"
            cell.cellTextfield.tag = indexPath.row
            cell.delegate = self as? customCellDelegate
        }
        else if indexPath.row == 1 {
             cell.cellLabel.text = "Email Address"
             cell.editButtonReference.tag = indexPath.row
             cell.cancelButtonReference.tag = indexPath.row
            cell.cellTextfield.text = "ernestyawgasiie@gmail.com"
             cell.cellTextfield.tag = indexPath.row
             cell.delegate = self as? customCellDelegate
        }
        
        else if indexPath.row == 2 {
             cell.cellLabel.text = "Mobile Number"
             cell.editButtonReference.tag = indexPath.row
             cell.cancelButtonReference.tag = indexPath.row
            cell.cellTextfield.text = "0552523469"
             cell.cellTextfield.tag = indexPath.row
             cell.delegate = self as? customCellDelegate
        }
        
        if selectedIndex == indexPath.row {
            cell.cellTextfield.layer.borderWidth = 1
            cell.cellTextfield.layer.borderColor = UIColor.orange.cgColor
            cell.cellTextfield.text = ""
            cell.cellTextfield.isUserInteractionEnabled = true
        }
        else
        {
            cell.cellTextfield.layer.borderWidth = 0
            cell.cellTextfield.layer.borderColor = UIColor.white.cgColor
            cell.cellTextfield.isUserInteractionEnabled = false
        }
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if selectedIndex == indexPath.row {
            return 185
        }
        else
        {
            return 130
        }
        
//        for i in 0..<cellsExpanded.count {
//            if indexPath.row == i {
//                if cellsExpanded[i] == true {
//                    return 185
//                }
//                else
//                {
//                    return 140
//                }
//            }
//
//        }
//        return 140
    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        for i in 0..<cellsExpanded.count {
//            if indexPath.row == i {
//                if cellsExpanded[i] {
//
//                    cellsExpanded[i] = false
//                } else {
//                    cellsExpanded[i] = true
//                }
//                tableView.beginUpdates()
//                tableView.endUpdates()
//            }
//        }
//    }
    
    
   
    
//    func updateCell(cellExpanded: Bool) {
//
//        for i in 0..<cellsExpanded.count {
//           if !cellsExpanded[i]
//           {
//            cellsExpanded[i] = cellExpanded
//            }
//
//
//        }
//        personalInfoTableView.beginUpdates()
//        personalInfoTableView.endUpdates()
//
//
//
//    }
}
    

