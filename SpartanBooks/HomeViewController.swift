//
//  HomeViewController.swift
//  SpartanBooks
//
//  Created by Cindy Ho on 4/16/18.
//  Copyright © 2018 Cindy Ho. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var postingsTableView: UITableView!
    
    var isSearching = false
    var selectedListing = 0
    var refTextbooks: DatabaseReference!
    var textbookList = [TextbookModel]()
    var filteredTextbooks = [TextbookModel]()
    
    override func viewDidAppear(_ animated: Bool) {
        // checks if the user is logged in before displaying the homepage
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if(!isUserLoggedIn) {
            self.performSegue(withIdentifier: "LoginView", sender: self)
        }
        
        // creates a reference of the children under "textbooks
        // all the textbook listings
        refTextbooks = Database.database().reference().child("textbook");
        
        // observe to iterate through all the children of textbook
        refTextbooks.observe(DataEventType.value, with: { (snapshot) in
            
            // checks if the reference has children
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
                    
                    //appending it to list
                    self.textbookList.append(textbook)
                }
                
                //reloading the tableview
                self.postingsTableView.reloadData()
            }
        })
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // returns the amount of listings there are
        if isSearching {
            return filteredTextbooks.count
        }
        return textbookList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //creating a cell using the custom class

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        // saves the row picked for contact seller
        let textbookPicked = textbookList[indexPath.row]
        cell.setTextbook(textbook: textbookPicked)
        
        //the textbook object
        let textbook: TextbookModel
        
        if isSearching {
            textbook = filteredTextbooks[indexPath.row]
        } else {
            //getting the textbook of selected position
            textbook = textbookList[indexPath.row]
            
        }
        //adding values to labels
        cell.labelTitle.text = textbook.title
        cell.labelAuthor.text = textbook.author
        cell.labelISBN.text = textbook.isbn
        cell.labelPrice.text = ("$\(textbook.price!)")
        cell.labelNotes.text = textbook.notes
        cell.contactBookSeller.tag = indexPath.row
        cell.delegate = self
        cell.selectionStyle = .none
        
        //returning cell
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        self.hideKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            postingsTableView.reloadData()
        } else {
            isSearching = true
            filteredTextbooks = textbookList.filter { ($0.title?.contains(searchBar.text!))!
                }
            postingsTableView.reloadData()
        }
    }

}

// using protocol/delegate technique to contact the seller
extension HomeViewController: contactSellerDelegate {
    func didContactSeller(email: String) {
        print("contacting seller")
        
        // this only works with a real iPhone not simulator
        UIApplication.shared.open(URL(string: "mailto:\(email)")! as URL, options: [:], completionHandler: nil)
    }
}
