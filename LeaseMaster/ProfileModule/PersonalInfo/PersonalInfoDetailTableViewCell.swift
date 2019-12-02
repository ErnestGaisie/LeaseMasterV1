//
//  PersonalInfoDetailTableViewCell.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 19/11/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

//private let _PersonalInfoViewCell_Shared_Instance = PersonalInfoDetailTableViewCell()

protocol customCellDelegate: class {
    func updateTableView(row: Int)
    //func collapseTableView(row: Int)
}

class PersonalInfoDetailTableViewCell: UITableViewCell {
    
    weak var delegate: customCellDelegate?
    
//    class var sharedInstance: PersonalInfoDetailTableViewCell
//       {
//           return _PersonalInfoViewCell_Shared_Instance
//       }
    
    var cellExpanded: Bool = false
    

    override func awakeFromNib() {
        super.awakeFromNib()
    
//        DispatchQueue.main.async {
//            self.cellTextfield.addTarget(self, action: #selector(self.textFieldEdititing(_:)), for: .editingDidBegin)
//        }
       
       // cellTextfield.addTarget(self, action: #selector(self.editingDone(_:)), for: .editingDidEnd)
        
        cellTextfield.layer.borderWidth = 0
        cellTextfield.layer.cornerRadius = 5
        //setupAccountTextfields(textField: cellTextfield)
        
    }

    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var editButtonReference: UIButton!
    @IBOutlet weak var cancelButtonReference: UIButton!
    
    @IBAction func editButton(_ sender: UIButton) {
        delegate?.updateTableView(row: sender.tag)
    }
    
    @IBOutlet weak var cellTextfield: UITextField!
    
    @IBAction func updateButton(_ sender: Any) {
    }
    
    @IBAction func cancelButton(_ sender: UIButton) {
        cellExpanded = false
        delegate?.updateTableView(row: sender.tag)
    }
    @IBOutlet weak var lowerView: UIView!
    
    @IBOutlet weak var profileLabel: UILabel!
    
    @objc func textFieldEdititing(_ textfield: UITextField) {
        cellTextfield.layer.borderWidth = 1.0
        cellTextfield.layer.borderColor = UIColor.orange.cgColor
    }
    
    @objc func editingDone (_ textfield: UITextField) {
        cellTextfield.layer.borderWidth = 0
    }
    
    
}
