//
//  ManageListingsTableViewCell.swift
//  SpartanBooks
//
//  Created by Cindy Ho on 5/1/18.
//  Copyright © 2018 Cindy Ho. All rights reserved.
//

import UIKit

class ManageListingsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var ISBNLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
}
