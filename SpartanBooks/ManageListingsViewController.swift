//
//  ManageListingsViewController.swift
//  SpartanBooks
//
//  Created by Cindy Ho on 5/1/18.
//  Copyright © 2018 Cindy Ho. All rights reserved.
//

import UIKit
import Firebase

class ManageListingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var managePostingsTableView: UITableView!
    var refTextbooks: DatabaseReference!
    
    var textbookList = [TextbookModel]()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textbookList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //creating a cell using the custom class
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ManageListingsTableViewCell
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        //the textbook object
        let textbook: TextbookModel
        
        //getting the textbook of selected position
        textbook = textbookList[indexPath.row]
        
        //adding values to labels
        cell.titleLabel.text = textbook.title
        cell.authorLabel.text = textbook.author
        cell.ISBNLabel.text = textbook.isbn
        cell.priceLabel.text = ("$\(textbook.price!)")
        cell.notesLabel.text = textbook.notes
        cell.selectionStyle = .none
        
        
        //returning cell
        return cell
    }
    
    //this function will be called when a row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //getting the selected artist
        let textbook  = textbookList[indexPath.row]
        
        //building an alert
        let alertController = UIAlertController(title: textbook.title, message: "Update Textbook Listing", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting artist id
            let id = textbook.id
            
            //getting new values
            let title = alertController.textFields?[0].text
            let author = alertController.textFields?[1].text
            let isbn = alertController.textFields?[2].text
            let price = alertController.textFields?[3].text
            let notes = alertController.textFields?[4].text
            
            //calling the update method to update textbook
            self.updateTextbook(id: id!, title: title!, author: author!, isbn: isbn!, price: price!, notes: notes!)
        }
        
        //the delete action calls deleteListing
        let deleteAction = UIAlertAction(title: "Delete", style: .cancel) { (_) in
            self.deleteListing(id: textbook.id!)
        }
        
        //adding five textfields to alert
        alertController.addTextField { (textField) in
            textField.text = textbook.title
        }
        alertController.addTextField { (textField) in
            textField.text = textbook.author
        }
        alertController.addTextField { (textField) in
            textField.text = textbook.isbn
        }
        alertController.addTextField { (textField) in
            textField.text = textbook.price
        }
        alertController.addTextField { (textField) in
            textField.text = textbook.notes
        }
        
        //adding actions
        alertController.addAction(confirmAction)
        alertController.addAction(deleteAction)
        
        //presenting dialog
        present(alertController, animated: true, completion: nil)
    }
    
    func updateTextbook(id:String, title:String, author:String, isbn:String, price:String, notes:String){
        //creating textbook with the new given values
        let textbook = ["id":id,
                      "title": title,
                      "author": author,
                      "isbn": isbn,
                      "price": price,
                      "notes": notes,
                      "seller": Auth.auth().currentUser!.email!
        ]
        
        //updating the artist using the key of the artist
        refTextbooks.child(id).setValue(textbook)
    }
    
    // not calling table view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refTextbooks = Database.database().reference().child("textbook");
        
        refTextbooks.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.textbookList.removeAll()
                
                //iterating through all the values
                for textbook in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let textbookObject = textbook.value as? [String: AnyObject]
                    let textbookName  = textbookObject?["title"]
                    let textbookId  = textbookObject?["id"]
                    let textbookAuthor = textbookObject?["author"]
                    let textbookIsbn = textbookObject?["isbn"]
                    let textbookPrice = textbookObject?["price"]
                    let textbookNotes = textbookObject?["notes"]
                    let textbookSeller = textbookObject?["seller"]
                    
                    //creating textbook object with model and fetched values
                    let textbook = TextbookModel(id: textbookId as! String?, title: textbookName as! String?, author: textbookAuthor as! String?, isbn: textbookIsbn as! String?, price: textbookPrice as! String?, notes: textbookNotes as! String?, seller: textbookSeller as! String?)
                    
                    // if the seller is the logged in user, append to list to edit
                    if(textbook.seller == Auth.auth().currentUser!.email!) {
                        self.textbookList.append(textbook)
                    }
                }
                
                //reloading the tableview
                self.managePostingsTableView.reloadData()
            }
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func deleteListing(id:String){
        refTextbooks.child(id).setValue(nil)
    }
}
