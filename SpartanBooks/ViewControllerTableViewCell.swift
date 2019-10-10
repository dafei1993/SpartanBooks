//
//  ViewControllerTableViewCell.swift
//  SpartanBooks
//
//  Created by Cindy Ho on 4/17/18.
//  Copyright © 2018 Cindy Ho. All rights reserved.
//

import UIKit

protocol contactSellerDelegate {
    func didContactSeller(email: String)
}

class ViewControllerTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setTextbook(textbook: TextbookModel){
        textbookListing = textbook
        textbookListing.seller = textbook.seller
    }
    
    // labels for the table
    @IBOutlet weak var contactBookSeller: UIButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelISBN: UILabel!
    @IBOutlet weak var labelNotes: UILabel!
    
    var delegate : contactSellerDelegate?
    var textbookListing: TextbookModel!

    @IBAction func contactButton(_ sender: UIButton) {
        // send seller's email to the delegate on the HomeViewController
        delegate?.didContactSeller(email: textbookListing.seller!)
    }
}
