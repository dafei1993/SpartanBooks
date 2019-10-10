//
//  RegisterViewController.swift
//  SpartanBooks
//
//  Created by Cindy Ho on 4/14/18.
//  Copyright © 2018 Cindy Ho. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class RegisterViewController: UIViewController {

    @IBOutlet weak var sjsuEmailTextField: UITextField!
    @IBOutlet weak var sjsuPasswordTextField: UITextField!
    @IBOutlet weak var sjsuPasswordConfirmTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerAccount(_ sender: UIButton) {
        let userEmail = sjsuEmailTextField.text
        let userPassword = sjsuPasswordTextField.text
        let userPasswordConfirm = sjsuPasswordConfirmTextField.text
        
        // check for empty fields
        if ((userEmail?.isEmpty)! || (userPassword?.isEmpty)! || (userPasswordConfirm?.isEmpty)!) {
            // display alert msg
            displayAlert(userMessage: "All fields required")
            return
        }
        
        // check if email is an email
        if (!((userEmail?.contains("@sjsu.edu"))!)) {
            displayAlert(userMessage: "Not an SJSU valid email")
            return
        }
        
        // check if passwords match
        if(userPassword != userPasswordConfirm) {
            // display alert msg
            displayAlert(userMessage: "Passwords do not match")
            return
        }
        
        // store data
//        UserDefaults.standard.set(userEmail, forKey: "userEmail")
//        UserDefaults.standard.set(userPassword, forKey: "userPassword")
//        UserDefaults.standard.synchronize()
        
        Auth.auth().createUser(withEmail: sjsuEmailTextField.text!, password: sjsuPasswordTextField.text!) { (user, error) in
            
            if error == nil {
                //print("You have successfully signed up")
                //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                
                //                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                //                self.present(vc!, animated: true, completion: nil)
                Auth.auth().currentUser!.sendEmailVerification(completion: { (error) in })
                let alert = UIAlertController(title: "Alert", message: "Account created. Please verify your email. Thank you!", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    action in self.dismiss(animated: true, completion: nil)
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        
        // display alert msg w confirmation
        let alert = UIAlertController(title: "Alert", message: "Registration Successful. Thank you!", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            action in self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    }
    
    func displayAlert(userMessage: String){
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
