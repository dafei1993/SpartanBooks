//
//  ViewController.swift
//  SpartanBooks
//
//  Created by Cindy Ho on 4/14/18.
//  Copyright © 2018 Cindy Ho. All rights reserved.\
//Test
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if(!isUserLoggedIn) {
            self.performSegue(withIdentifier: "LoginView", sender: self)
        }
    }
}

