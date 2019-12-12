//
//  savedDetailViewController.swift
//  LeaseMaster
//
//  Created by Ernest Boamah Gaisie on 10/12/2019.
//  Copyright © 2019 Qodehub. All rights reserved.
//

import UIKit

class savedDetailViewController: UIViewController {
    
    var properties: [savedProperty] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension savedDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
    }
    
    
}
