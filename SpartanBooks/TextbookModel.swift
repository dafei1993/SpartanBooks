//
//  TextbookModel.swift
//  SpartanBooks
//
//  Created by Cindy Ho on 4/17/18.
//  Copyright © 2018 Cindy Ho. All rights reserved.
//

class TextbookModel {
    var id: String?
    var title: String?
    var author: String?
    var price: String?
    var isbn: String?
    var notes: String?
    var seller: String?
    
    init(id: String?, title: String?, author: String?, isbn: String?, price: String?, notes: String?, seller: String?){
        self.id = id
        self.title = title
        self.author = author
        self.isbn = isbn
        self.price = price
        self.notes = notes
        self.seller = seller
    }
}
