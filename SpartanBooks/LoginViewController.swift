//
//  LoginViewController.swift
//  SpartanBooks
//
//  Created by Cindy Ho on 4/14/18.
//  Copyright © 2018 Cindy Ho. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var sjsuEmailTextField: UITextField!
    @IBOutlet weak var sjsuPasswordTextField: UITextField!
    
    @IBAction func loginUser(_ sender: UIButton) {

        Auth.auth().signIn(withEmail: self.sjsuEmailTextField.text!, password: self.sjsuPasswordTextField.text!) { (user, error) in
            
            if error == nil {
                
                if let user = Auth.auth().currentUser {
                    if !user.isEmailVerified{
                        let alertVC = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified.", preferredStyle: .alert)
                        let alertActionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertVC.addAction(alertActionOK)
                        self.present(alertVC, animated: true, completion: nil)
                    } else {
                        print ("Email verified. Signing in...")
                    }
                }
                
                //Print into the console if successfully logged in
                print("You have successfully logged into SpartansBooks")
                
                // Login is successful
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize()
                self.performSegue(withIdentifier: "HomeView", sender: self)
            } else {
                
                //Tells the user that there is an error and then gets firebase to tell them the error
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
