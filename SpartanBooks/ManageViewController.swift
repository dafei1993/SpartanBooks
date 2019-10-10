//
//  ManageViewController.swift
//  SpartanBooks
//
//  Created by Cindy Ho on 4/16/18.
//  Copyright © 2018 Cindy Ho. All rights reserved.
//

import UIKit

class ManageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // This button goes to the account view, where they can sign up
    // Later: profile settings?
    @IBAction func manageAccount(_ sender: UIButton) {
        performSegue(withIdentifier: "AccountView", sender: self)
    }
    
    // This button takes the user to a list of their listings so they can edit or delete
    @IBAction func manageListingsView(_ sender: UIButton) {
        performSegue(withIdentifier: "ListingView", sender: self)
    }
}
