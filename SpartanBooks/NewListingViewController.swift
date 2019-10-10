//
//  NewListingViewController.swift
//  SpartanBooks
//
//  Created by Cindy Ho on 4/17/18.
//  Copyright © 2018 Cindy Ho. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class NewListingViewController: UIViewController {
    
    // text fields for forms
    @IBOutlet weak var textbookNameTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var isbnTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    var refTextbooks: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // creates reference for textbook listings
        refTextbooks = Database.database().reference().child("textbook");
        self.hideKeyboard()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func postListing(){
        let key = refTextbooks.childByAutoId().key
        let textbookNameText = textbookNameTextField.text
        let authorText = authorTextField.text
        let isbnText = isbnTextField.text
        let priceText = priceTextField.text
        let notesText = notesTextField.text
        
        // check for empty fields
        if ((textbookNameText?.isEmpty)! || (authorText?.isEmpty)! || (isbnText?.isEmpty)! || (priceText?.isEmpty)!)
        {
            // display alert msg
            displayAlert(userMessage: "All fields required.")
            return
        }
        
        // check if isbn is a valid length
        if((isbnText?.count)! != 13) {
            displayAlert(userMessage: "Enter a valid ISBN-13 number.")
            return
        }
        
        // check if price is a numerical number
        if(!isStringAnInt(string: (priceText)!)){
            displayAlert(userMessage: "Enter a numeric value for price. ")
            return
        }
        
        // creates listing with a new key
        let textbook = ["id":key, "title":textbookNameText! as String, "author":authorText! as String, "isbn":isbnText! as String, "price":priceText! as String, "notes":notesText! as String, "seller": Auth.auth().currentUser!.email! as String]
        refTextbooks.child(key).setValue(textbook)
        
        // go to home after posting
        performSegue(withIdentifier: "HomeView", sender: self)
    }
    
    @IBAction func createPost(_ sender: UIButton) {
       postListing()
    }
    
    func displayAlert(userMessage: String){
        let alert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func isStringAnInt(string: String) -> Bool {
        return Int(string) != nil
    }
}

// extension to hide the keyboard
extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
