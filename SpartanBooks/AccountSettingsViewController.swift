//
//  AccountSettingsViewController.swift
//  SpartanBooks
//
//  Created by Cindy Ho on 4/15/18.
//  Copyright © 2018 Cindy Ho. All rights reserved.
//

import UIKit

class AccountSettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // This function allows the user to log out of their account
    @IBAction func logoutUser(_ sender: Any) {
        UserDefaults.standard.set(false, forKey:"isUserLoggedIn")
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "LoginView", sender: self)
    }

}
